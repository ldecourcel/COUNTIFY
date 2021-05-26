class InvoicesController < ApplicationController

  def index
    @company = Company.find(params[:company_id])
    @invoices = policy_scope(Invoice).order(created_at: :desc).where(company_id: @company.id)
  end

  def show
    @invoice = Invoice.find(params[:id])
    authorize @invoice
  end
end
