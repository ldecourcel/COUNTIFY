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
    record.company.accountant_id == user.accountant_id || record.company_id == user.company_id
  end

  def new?
    user.accountant_id == Company.find(record.company_id).accountant_id || user.company_id == record.company_id
  end

  def create?
    new?
  end

  def edit?
    Company.find(record.company_id).accountant_id == user.id
  end

  def update?
    Company.find(record.company_id).accountant_id == user.accountant_id || user.company_id == record.company_id
  end

  def destroy?
    # record.user == user
    user.is_accountant?
  end
end
