class V1::BaseController < ApplicationController

  before_filter :authenticate, except: :render_404

  def render_404
    render json: {error: {message: "invalid url", code: 404}}, status: :not_found
  end

  protected

  def authenticate
    return render json: {error: {message: "this operation requires access_token param", code: 1001}}, status: :unauthorized if params[:access_token].blank?
    @current_user ||= User.where(id: params[:access_token]).first
    return render json: {error: {message: "access_token param does not match any users", code: 1002}}, status: :forbidden if @current_user.nil?
  end

  rescue_from ActiveRecord::RecordNotFound, with: :render_404

end
