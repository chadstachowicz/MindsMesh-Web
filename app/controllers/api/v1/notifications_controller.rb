module Api::V1
  class NotificationsController < BaseController
  

    # GET /api/v1/notifications/1
    def show
      n = Notification.find(params[:id])
      n.mark_as_read!
      render json: NotificationPresenter.new(n).with_parents
    end

    # GET /api/v1/notifications/grouped_with_parents
    def grouped_with_parents
      @unread = @current_user.notifications.unread.limit(5)
      @read   = @current_user.notifications.read.limit(10)

      render json: {read:   NotificationPresenter.array(@read).with_parents,
                    unread: NotificationPresenter.array(@unread).with_parents
                    }
    end

    # GET /api/v1/notifications/1/mark_as_read
    def mark_as_read
      n = Notification.find(params[:id])
      n.mark_as_read!
      render json: true
    end

  end
end