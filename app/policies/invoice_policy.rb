class InvoicePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    Company.find(record.company_id).accountant_id == user.id
  end

  def show?
    index?
  end

  def new?
    user.is_accountant? || user.is_company?

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
