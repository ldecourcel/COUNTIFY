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
    user.is_accountant?
  end

  def create?
    new?
  end

  def edit?
    record.user == user
  end

  def update?
    edit
  end

  def destroy?
    record.user == user
  end
end
