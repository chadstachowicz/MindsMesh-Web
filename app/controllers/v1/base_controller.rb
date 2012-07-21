class V1::BaseController < ApplicationController
  
  protected

  def authenticate
    @me ||= User.where(id: params[:access_token]).first
    return render json: {error: {message: "invalid access_token", code: 1}} if @me.nil?
  end
end
