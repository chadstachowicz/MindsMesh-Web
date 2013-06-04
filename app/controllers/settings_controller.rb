class SettingsController < ApplicationController

  authorize_resource class: false

  def denied
    redirect_to_landing_home_page
  end

    
  def index
      @user = current_user
  end


end
