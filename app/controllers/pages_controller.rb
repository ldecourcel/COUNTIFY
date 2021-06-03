class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def components
  end

  def download
    send_file "#{Rails.root}/app/assets/images/Export_02062021.zip"
    @company = Company.find(params[:company])
    flash.now[:notice] = "coucou"
  end
end
