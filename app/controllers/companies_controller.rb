class CompaniesController < ApplicationController

  def index
    @companies = policy_scope(Company).order(created_at: :desc)
  end

  def new
    @company = Company.new
    authorize @company
  end

  def create
    @company = Company.new(company_params)
    authorize @company
    @company.accountant_id = current_user
    if @company.save
      redirect_to companies
    else
      render :new
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :siren, :siret, :fiscal_regim, :address, :phone_number)
  end

end
