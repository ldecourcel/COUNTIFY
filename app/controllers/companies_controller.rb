class CompaniesController < ApplicationController

  def index
    @companies = policy_scope(Company).order(created_at: :desc)
    authorize @companies
  end

  def show
    @company = Company.find(params[:id])
    @user = User.find_by(company_id: @company.id)
    authorize @company
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

  def update
    @company = Company.find(params[:id])
    @company.update(company_params)
    authorize @company
    redirect_to company_path(@company)
  end

  private

  def company_params
    params.require(:company).permit(:name, :siren, :siret, :fiscal_regim, :address, :phone_number)
  end
end
