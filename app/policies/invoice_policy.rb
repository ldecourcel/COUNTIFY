class InvoicePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index
    record.user == user
  end

  def show
    index
  end

  def new?
    user.is_accountant?
  end

  def create?
    new?
  end

  def edit
    record.user == user
  end

  def update
    edit
  end

  def destroy
    record.user == user
  end
end
