class InvoicesController < ApplicationController
  def index
    @company = Company.find(params[:company_id])
    @invoices = policy_scope(Invoice).where(company_id: @company.id).order(created_at: :desc)
  end

  def show
    @invoice = Invoice.find(params[:id])
    @company = @invoice.company
    authorize @invoice
  end

  def new
    @company = Company.find(params[:company_id])
    @invoice = Invoice.new
    authorize @invoice
  end

  def create
    @invoice = Invoice.new(invoice_params)
    authorize @invoice
    @invoice.company_id = params[:company_id]
    if @invoice.save
      redirect_to company_invoices_path
    else
      render :new
    end
  end

  def update
    @invoice = Invoice.find(params[:id])
    @invoice.update!(invoice_params)

    authorize @invoice
    redirect_to invoice_path(@invoice)
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
