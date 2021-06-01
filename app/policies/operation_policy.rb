class OperationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    record.account.company.accountant_id == user.accountant_id || record.account.company_id == user.company_id
  end

  def new?
    ##API
  end

  def create?
    ##API
  end

  def edit?
    record.account.company.accountant == user.accountant
    # show?
  end

  def update?
    edit?
    # show?
  end

end
