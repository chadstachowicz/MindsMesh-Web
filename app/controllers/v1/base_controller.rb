class V1::BaseController < ApplicationController
  
  protected

  def authenticate
    return render json: {error: {message: "this operation requires access_token param", code: 1001}} if params[:access_token].blank?
    @me ||= User.where(id: params[:access_token]).first
    return render json: {error: {message: "access_token param does not match any users", code: 1002}} if @me.nil?
  end
end
