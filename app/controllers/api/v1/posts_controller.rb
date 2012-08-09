module Api::V1
  class PostsController < BaseController

    def show
      render json: PostPresenter.new(post)
    end

    def with_children
      render json: PostPresenter.new(post).with_children
    end

    def likes
      render json: LikePresenter.array(post.likes)
    end

    def likes_with_parents
      render json: LikePresenter.array(post.likes).map(&:with_parents)
    end

    def like
      #doesn't do anything if user already liked it
      Like.create user: @current_user, likable: post
      render json: {likes_count: post.reload.likes.size}
    end

    def unlike
      #doesn't do anything if user never liked it
      Like.where(user_id: @current_user.id, likable_type: post.class.name, likable_id: post.id).first.try(:destroy)
      render json: {likes_count: post.reload.likes.size}
    end

    def create_reply
      reply = post.replies.build(params[:reply])
      reply.user = @current_user
      reply.save!
      render json: reply
    end

    def create
      topic_user = @current_user.topic_users.find(params[:topic_user_id])
      post = Post.create_with!(topic_user, params[:post])
      render json: PostPresenter.new(post)
    end

    private

    def post
      @post ||= Post.find(params[:id])
    end
  end
end