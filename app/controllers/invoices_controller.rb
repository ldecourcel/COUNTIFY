
class InvoicesController < ApplicationController
  # /companies/:company_id/invoices
  def index
    @company = Company.find(params[:company_id])

    if params[:query].present?
      @invoices = policy_scope(Invoice).where(company_id: @company.id).global_search_invoice(params[:query])
    else
      @invoices = policy_scope(Invoice).where(company_id: @company.id)
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
    params.require(:invoice).permit(:date, :net_amount, :issuer, :vta, :payment_method, :tax_amount, :total_amount, :client, :invoice_number, photos: [])
  end

end
