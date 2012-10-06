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

end
