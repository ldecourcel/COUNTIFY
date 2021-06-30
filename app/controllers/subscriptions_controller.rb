class SubscriptionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new_role]

  def new_role
    skip_authorization
  end

  def add_account
    @company = Company.find(current_user.company_id)
    skip_authorization
  end
end
