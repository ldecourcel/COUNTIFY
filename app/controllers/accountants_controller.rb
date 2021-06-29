class AccountantsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @accountant = Accountant.new

    authorize @accountant
    # skip_authorization
  end

  def create
    @accountant = Accountant.new(accountant_params)
    authorize @accountant

    if @accountant.save
      redirect_to new_user_registration_path(param: ["comptable", @accountant])
    else
      render :new
    end
  end

  private

  def accountant_params
    params.require(:accountant).permit(:name)
  end
end
