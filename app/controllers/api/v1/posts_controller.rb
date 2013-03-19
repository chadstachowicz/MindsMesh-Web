module Api::V1
  class PostsController < BaseController

    def index
        #  posts = @current_user.posts_feed(params.slice(:limit, :before))
        posts = @current_user.posts_feed_old(params.slice(:limit, :before))
      render json: PostPresenter.array(posts).to_json
    end

    def posts_with_family
        # posts = @current_user.posts_feed(params.slice(:limit, :before))
        posts = @current_user.posts_feed_old(params.slice(:limit, :before))
      render json: PostPresenter.array(posts).with_family
    end

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
        @post = Post.new(:topic_user_id => params[:topic_user_id], :text => params[:text])
        @post.save
	if params[:filename]
        @post_a = PostAttachment.new(:file_file_name => params[:filename], :file_content_type => params[:content_type], :post_id => @post.id, :link_url => (ENV['RAILS_ENV'] + "/post_attachments/" + @post.id.to_s + "/" + params[:filename]))
        @post_a.save
        end
       render json: PostPresenter.new(post)
    end

    private

    def post
      @post ||= Post.find(params[:id])
    end
  end
end