class RepliesController < ApplicationController
  load_resource
  load_and_authorize_resource only: [:update]

  # PUT /replies/1
  def update
    if @reply.update_attributes(params[:reply])
      head :no_content
    else
      render json: @reply.errors, status: :unprocessable_entity
    end
  end

  # PUT /replies/1/like
  def like
    #doesn't do anything if user already liked it
    Like.create user: current_user, likable: @reply
    render text: @reply.likes.size
    #render js: "setTimeout( function() {$('#reply_#{@reply.id} span').html('#{@reply.likes.size}')}, 500)"
  end

  #TODO: delete reply
  # DELETE /replies/1
  #def destroy
  #  @reply.destroy
  #  respond_with(@reply)
  #end
end
