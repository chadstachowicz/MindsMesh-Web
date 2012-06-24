class RepliesController < ApplicationController
  load_resource

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
