class SubscriptionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new_role?
    true
  end

  def add_account?
    true
  end
end
