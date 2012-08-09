module Api::V1
  class RepliesController < BaseController

    def show
      render json: reply
    end

    def likes
      render json: LikePresenter.array(reply.likes)
    end

    def likes_with_parents
      render json: LikePresenter.array(reply.likes).map(&:with_parents)
    end

    def like
      #doesn't do anything if user already liked it
      Like.create user: @current_user, likable: reply
      render json: {likes_count: reply.reload.likes.size}
    end

    def unlike
      #doesn't do anything if user never liked it
      Like.where(user_id: @current_user.id, likable_type: reply.class.name, likable_id: reply.id).first.try(:destroy)
      render json: {likes_count: reply.reload.likes.size}
    end

    private

    def reply
      @reply ||= Reply.find(params[:id])
    end
  end
end