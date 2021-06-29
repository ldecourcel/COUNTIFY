class CompaniesController < ApplicationController
  skip_before_action :authenticate_user!

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
    company_params[:accountant_id] = company_params[:accountant_id].to_i
    @company = Company.new(company_params)
    authorize @company
    if @company.save
      redirect_to new_user_registration_path(param: ["company", @company])
    else
      raise
      render :new
    end
  end

  def update
    @company = Company.find(params[:id])
    @company.update(company_params)
    authorize @company
    redirect_to company_path(@company)
  end

  def dashboard
    @company = Company.find(params[:id])
    authorize @company
    @operations = policy_scope(@company.operations).order(date: :desc)
  end

  private

  def company_params
    params.require(:company).permit(:name, :siren, :siret, :fiscal_regim, :address, :phone_number, :accountant_id)
  end
end
