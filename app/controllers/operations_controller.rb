class OperationsController < ApplicationController
  def index
    find_company
    if params[:query].present?
      @operations = policy_scope(Operation).global_search(params[:query])
    else
      @operations = policy_scope(Operation).order(date: :desc)
    end
  end

  private 

  def find_company 
    @company = Company.find(params[:company_id])
  end
end
