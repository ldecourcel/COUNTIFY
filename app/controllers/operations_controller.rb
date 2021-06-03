class OperationsController < ApplicationController

  helper_method :sort_column, :sort_direction

  def index
    find_company
    if params[:query].present?
      @operations = policy_scope(@company.operations).global_search(params[:query]).order(sort_column + " " + sort_direction)
    else
      @operations = policy_scope(@company.operations).order(sort_column + " " + sort_direction)
    end

    @invoices = policy_scope(Invoice).order(created_at: :desc).where(company_id: @company.id)
    @gains = []
    @operations.each { |operation| @gains << operation.amount if operation.amount > 0 }
    @expenses = []
    @operations.each { |operation| @expenses << operation.amount  if operation.amount < 0 }

    @operations.each do |operation|
      @invoices.each do |invoice|
        if invoice.total_amount == operation.amount.abs
          operation.invoice = invoice
          operation.save!
        end
      end
    end

  end

  def new
    find_company
    @account = @company.accounts.last
    @operation = Operation.new
    @operation.account = @account
    authorize @operation
  end

  def create
    find_company
    @account = Account.find(params[:operation][:account].to_i)

    @operation = Operation.new(operation_params)
    @operation.account = @account
    @company = @operation.account.company
    authorize @operation

    if @operation.save
      redirect_to company_operation_path(@company, @operation)
    else
      render :new
    end
  end

  def show
    find_operation
    find_company
    @invoices = policy_scope(Invoice).order(created_at: :desc).where(company_id: @company.id)

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
      redirect_to company_operation_path(params[:company_id], @operation)
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

  def sort_column
    if params[:sort] == "details"
      @company.operations.column_names.include?(params[:sort]) ? "lower(#{params[:sort]})" : "date"
    else
      @company.operations.column_names.include?(params[:sort]) ? params[:sort] : "date"
    end
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def operation_params
    params.require(:operation).permit(:date, :amount, :details, :category)
  end

end
