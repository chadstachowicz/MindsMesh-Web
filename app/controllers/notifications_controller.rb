class NotificationsController < ApplicationController
  load_and_authorize_resource

  def show
  	@notification.mark_as_read!
  	return redirect_to @notification.target if @notification.target.is_a? Post
  	return redirect_to @notification.target if @notification.target.is_a? Topic
  	return redirect_to @notification.target.post if @notification.target.is_a? Reply
    return redirect_to @notification.target if @notification.target.is_a? Group
  	render "cannot redirect to a #{@notification.target.class.name}"
  end
end
