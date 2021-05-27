class OperationsController < ApplicationController
  def index
    find_company
    if params[:query].present?
      @operations = policy_scope(@company.operations).global_search(params[:query])
    else
      @operations = policy_scope(@company.operations).order(date: :desc)
    end
  end

  def show
    find_operation
    @company = @operation.account.company
    @invoices = policy_scope(Invoice).order(created_at: :desc).where(company_id: @company.id)
    
    @invoices.each do |invoice|
      if invoice.total_amount == @operation.amount.abs
        @operation.invoice = invoice
        @operation.save!
      end
    end

    @invoices_to_display = []
    hash = {}

    @invoices.each do |invoice|
      difference = 0
      difference = @operation.amount.abs - invoice.total_amount
      hash[invoice] = difference.abs
      hash.sort_by(&:last)
      @invoices_to_display = hash.sort_by(&:last).first(5)
    end
    authorize @operation
  end

  def update
    find_operation
    @invoice = Invoice.find(params[:invoice])
    @operation.invoice = @invoice
    @operation.validated = true
    if @operation.save!
      redirect_to operation_path(@operation)
    end
  end

  private

  def find_company 
    @company = Company.find(params[:company_id])
  end

  def find_operation
    @operation = Operation.find(params[:id])
    authorize @operation
  end

end
