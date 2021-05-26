class OperationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    record.user == user
  end

  def show?
    # @operation = Operation.find(params[:id])
    record.user == user
  end

  def new?
    ##API
  end

  def create
    ##API
  end

  def edit?
    record.user == user
  end

  def update?
    edit?
  end

  def destroy
    record.user == user
  end

end
