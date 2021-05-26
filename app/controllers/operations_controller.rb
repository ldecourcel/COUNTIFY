class OperationsController < ApplicationController
  def index
    find_company
    if params[:query].present?
      @operations = policy_scope(Operation).global_search(params[:query])
    else
      @operations = policy_scope(Operation).order(date: :desc)
    end
  end

  def show
    find_operation
    authorize @operation
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
