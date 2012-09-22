class PostAttachmentsController < ApplicationController
  load_and_authorize_resource
  def destroy
    #@post_attachment.destroy
    render json: true
  end
end
