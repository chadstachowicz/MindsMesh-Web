class SettingsController < ApplicationController

 load_and_authorize_resource class: false

    
  def index
      @user = current_user
  end
  
  def notifications
      @user = current_user
  end


end
