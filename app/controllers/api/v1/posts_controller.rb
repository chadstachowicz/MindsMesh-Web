module Api::V1
  class PostsController < BaseController

    def index
        #  posts = @current_user.posts_feed(params.slice(:limit, :before))
        posts = @current_user.posts_feed(params.slice(:limit, :before))
      render json: PostPresenter.array(posts).to_json
    end

    def posts_with_family
        # posts = @current_user.posts_feed(params.slice(:limit, :before))
        posts = @current_user.posts_feed(params.slice(:limit, :before))
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
      
      # POST Encode_Video
      def encode_video
          response = Zencoder::Job.create({:input => params[:file],:output => {:width => 480, :public => true, :url => params[:file], :thumbnails => [{:label => 'first', :number => 1, :public => true, :base_url => params[:file][0..-9]}] } })
          render json: response
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
        if params[:topic_id] != nil
            @post = Post.new(:user_id => @current_user.id, :topic_id => params[:topic_id], :text => params[:text])
        elsif params[:group_id] != nil
            @post = Post.new(:user_id => @current_user.id, :group_id => params[:group_id], :text => params[:text])
        else
            @post = Post.new(:user_id => @current_user.id, :text => params[:text])
        end

        @post.save
        if params[:filename]
            @post_a = PostAttachment.new(:file_file_name => params[:filename], :file_content_type => params[:content_type], :post_id => @post.id, :link_url => ('development' + "/post_attachments/" + @post.id.to_s + "/" + params[:filename]))
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