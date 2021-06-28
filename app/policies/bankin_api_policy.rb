class BankinPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

 def new_user?
    true
  end

  def list_users?
    true
  end

  def authenticate_user?
    true
  end

  def synchronize_item?
    true
  end

  def connect_item?
    true
  end

  def list_items?
    true
  end

  def list_transactions?
    true
  end
end
