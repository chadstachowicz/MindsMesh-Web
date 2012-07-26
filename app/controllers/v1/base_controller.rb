class V1::BaseController < ApplicationController

  before_filter :authenticate, except: :render_404

  def render_404
    render json: {error: {message: "invalid url", code: 404}}, status: :not_found
  end

  protected

  def authenticate
    return render json: {error: {message: "this operation requires access_token param", code: 1001}}, status: :unauthorized if params[:access_token].blank?
    @current_user ||= User.where(access_token: params[:access_token]).first
    return render json: {error: {message: "access_token param not found in our servers", code: 1002}}, status: :unauthorized if @current_user.nil?
  end

  rescue_from Exception, with: :render_406

  def render_406(exception)
    data =  {
              error: {
                message: exception.message,
                code: 1000,
                exception: exception.class.name,
                params: params
              }
            }
    render json: data, status: :not_acceptable
  end

end
