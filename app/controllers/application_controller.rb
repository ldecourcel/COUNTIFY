class ApplicationController < ActionController::Base
  include Pundit

  before_action :authenticate_user!

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  def after_sign_in_path_for(user)
    if user.accountant_id?
      companies_path
    elsif user.company_id?
      if Company.find(user.company_id).accounts.size > 0
        company_operations_path(user.company)
      else
        add_account_path
      end
    else
      root_path
    end
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :accountant_id, :company_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:last_name, :first_name, :accountant_id, :company_id])
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
