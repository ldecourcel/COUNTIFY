class SubscriptionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new_role]

  def new_role
    skip_authorization
  end
end
