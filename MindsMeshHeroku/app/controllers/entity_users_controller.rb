
# MindsMesh, Inc. (c) 2012-2013

class EntityUsersController < ApplicationController

  load_and_authorize_resource

  def create
    begin
      EntityUser.transaction do
        @eur = EntityUserRequest.where(user_id: @entity_user.user_id, entity_id: @entity_user.entity_id).first_or_initialize
        @eur.email = params[:email]
        @eur.save!
        @entity_user.save!
      end
      render json: true
    rescue Exception => e
      render status: 500, json: {message: e.message}
    end
  end

  # DELETE /entity_users/1
    def destroy
        @entity_user.destroy
        render json: true
    end
    
    # PUT /entity_users/1
    def update
        #@user.update_attributes(params[:user])
        if @entity_user.update_attributes(params[:entity_user])
            flash[:notice] = "Entity User successfully updated."
        end
        render json: @entity_user
    end
end
