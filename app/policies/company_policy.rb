class CompanyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user.is_accountant?
  end

  def show?
    if user.is_accountant?
      @record.accountant_id == user.id
    elsif user.is_company?
      @record.id == user.company_id
    end
  end

  def new?
    true
  end

  def create?
    new?
  end

  def update?
    new?
  end
  
end
