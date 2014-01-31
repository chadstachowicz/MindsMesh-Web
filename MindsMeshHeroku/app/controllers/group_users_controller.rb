class GroupUsersController < ApplicationController

  load_and_authorize_resource

  # DELETE /entity_users/1
    def destroy
        @group_user.destroy
        render json: true
    end
    
    # PUT /entity_users/1
    def update
        #@user.update_attributes(params[:user])
        if @group_user.update_attributes(params[:group_user])
            flash[:notice] = "Group User successfully updated."
        end
        render json: @group_user
    end
end
