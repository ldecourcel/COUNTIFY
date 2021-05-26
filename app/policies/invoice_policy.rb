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
    record.user == user
  end

  def create?
    record.user == user
  end

  def edit?
    Company.find(record.company_id).accountant_id == user.id
  end

  def update?
    edit?
  end

  def destroy?
    record.user == user
  end
end
