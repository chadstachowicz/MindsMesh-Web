class FeedbackBugsController < ApplicationController

 load_and_authorize_resource

    
  def index
      @user = current_user
  end
    
    # GET /entity_lms/new
    def new
    end
    
    # POST /topics
    def create
        if @feedback_bug.save
            flash[:notice] = "Feedback successfully created."
        end
        redirect_to root_path
    end
    
    # GET /entity_lms/1/edit
    def edit
    end
    
    # GET /entity_lms/1
    def show
    end
    
    def destroy
        @feedback_bug.destroy
        redirect_to feedback_bugs_url
    end


end
