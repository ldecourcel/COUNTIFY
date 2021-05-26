class InvoicesController < ApplicationController

  def index
    @company = Company.find(params[:company_id])
    @invoices = policy_scope(Invoice).order(created_at: :desc).where(company_id: @company.id)
  end

  def show
    @invoice = Invoice.find(params[:id])
    authorize @invoice
  end

  def update
    @invoice = Invoice.find(params[:id])
    @invoice.update(invoice_params)
    authorize @invoice
    redirect_to invoice_path(@invoice)
  # update your resource from params
    # render partial: 'resources/item', locals: { invoice: @invoice }
  end

  private
  def invoice_params
    params.require(:invoice).permit(:photo, :date, :net_amount, :issuer, :vta, :payment_method, :tax_amount, :total_amount, :client)
  end
end
