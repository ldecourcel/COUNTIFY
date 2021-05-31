class InvoicePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
      if user.is_accountant?
        scope.where(company: user.accountant.companies)
      elsif user.is_company?
        scope.where(company: user.company)
      else
        Invoice.none
      end
    end
  end

  def show?
    record.company.accountant_id == user.id || record.company_id == user.company.id
  end

  def new?
    # params[:company_id]
    # raise
    user.accountant_id == user.id || user.company_id == user.id
    # raise
  end

  def create?
    new?
  end

  def edit?
    Company.find(record.company_id).accountant_id == user.id
  end

  def update?
    edit?
  end

  def destroy?
    # record.user == user
    user.is_accountant?
  end
end
