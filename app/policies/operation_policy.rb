class OperationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    # raise 
    record.account.company.accountant == user.accountant
  end

  def new?
    ##API
  end

  def create?
    ##API
  end

  def edit?
    show?
  end

  def update?
    show?
  end

end
