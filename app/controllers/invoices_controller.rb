class InvoicesController < ApplicationController
  def index
    @company = Company.find(params[:company_id])
    @invoices = policy_scope(Invoice).order(created_at: :desc).where(company_id: @company.id)
  end

  def show
    @invoice = Invoice.find(params[:id])
    authorize @invoice
  end
  
  def new
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

  private

  def invoice_params
    params.require(:invoice).permit(:photo, :date, :net_amount, :issuer, :vta, :payment_method, :tax_amount, :total_amount, :client)
  end
end
