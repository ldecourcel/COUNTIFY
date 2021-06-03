
class InvoicesController < ApplicationController

  helper_method :sort_column, :sort_direction
  # /companies/:company_id/invoices
  def index
    @company = Company.find(params[:company_id])

    # raise
    if params[:type] && params[:direction] == "desc" || params[:direction].nil?
      @invoices_neg = policy_scope(Invoice).where(company_id: @company.id).where(client: @company.name).order("total_amount_cents desc")
      @invoices_pos = policy_scope(Invoice).where(company_id: @company.id).where.not(client: @company.name).order("total_amount_cents asc")
      @invoices = @invoices_neg + @invoices_pos
      @direction = "asc"
    elsif params[:type] && params[:direction] == "asc"
      @invoices_neg = policy_scope(Invoice).where(company_id: @company.id).where(client: @company.name).order("total_amount_cents asc")
      @invoices_pos = policy_scope(Invoice).where(company_id: @company.id).where.not(client: @company.name).order("total_amount_cents desc")
      @invoices = @invoices_pos + @invoices_neg
      @direction = "desc"
    elsif params[:query].present?
      @invoices = policy_scope(Invoice).where(company_id: @company.id).global_search_invoice(params[:query]).order(sort_column + " " + sort_direction)
    else
      @invoices = policy_scope(Invoice).where(company_id: @company.id).order(sort_column + " " + sort_direction)
    end
  end

  def show
    @company = Company.find(params[:company_id])
    @invoice = Invoice.find(params[:id])
    authorize @invoice
  end

  def new
    @company = Company.find(params[:company_id])
    @invoice = Invoice.new
    @invoice.company = @company
    authorize @invoice
  end

  def create
    invoice = Invoice.new(invoice_params)
    file = invoice_params[:photos].first.tempfile
    @invoice = InvoicesApi.new(invoice).call(file)
    @invoice.company_id = params[:company_id]
    @company = Company.find(@invoice.company_id)
    @invoice.client = @company.name
    authorize @invoice
    if @invoice.save
      redirect_to company_invoice_path(@company, @invoice)
    else
      render :new
    end
  end

  def update
    @invoice = Invoice.find(params[:id])
    @invoice.update!(invoice_params)

    authorize @invoice
    redirect_to company_invoice_path(params[:company_id], @invoice)
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    authorize @invoice
    @invoice.destroy
    redirect_to company_invoices_path(@invoice.company)
  end

  private

  def invoice_params
    params.require(:invoice).permit(:date, :issuer, :vta, :payment_method, :client, :invoice_number, :total_amount_cents, :net_amount_cents, :tax_amount_cents, photos: [])
  end

  def sort_column
    if params[:sort] == "details"
      @company.invoices.column_names.include?(params[:sort]) ? "lower(#{params[:sort]})" : "date"
    else
      @company.invoices.column_names.include?(params[:sort]) ? params[:sort] : "date"
    end
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
