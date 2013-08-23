class FeedbackBugsController < ApplicationController

 load_and_authorize_resource

    
  def index
      @user = current_user
      @feedback = FeedbackBug.new
  end


end
