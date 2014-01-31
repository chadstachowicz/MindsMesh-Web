class TopicUsersController < ApplicationController
    load_and_authorize_resource
    
    # DELETE /entity_users/1
    def destroy
        @topic_user.destroy
        render json: true
    end
    
    # PUT /entity_users/1
    def update
        #@user.update_attributes(params[:user])
        if @topic_user.update_attributes(params[:topic_user])
            flash[:notice] = "Group User successfully updated."
        end
        render json: @topic_user
    end

end