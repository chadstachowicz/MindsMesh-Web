module Api::V1
  class TopicsController < BaseController

=begin 
  def batch
  	return render json: {error: {message: "this operation requires topic_ids param separated between underscores. example: 1_12_312_4", code: 4001}}, status: :not_acceptable if params[:topic_ids].blank?
  	topics = Topic.where(id: params[:topic_ids].split('_'))
  	render json: V1::TopicPresenter.array(topics)
  end
=end

    def create
      topic = Topic.new(params[:topic])
      #topic.user = @current_user #TODO: add user_id field
      topic.save!
      topic.user_join(@current_user) #TODO: move this to a before create
      render json: TopicPresenter.new(topic)
    end

    def show
      render json: TopicPresenter.new(topic)
    end

    def posts
    	posts = topic.posts(params.slice(:limit, :before))
    	render json: PostPresenter.array(posts)
    end

    def posts_with_parents
      posts = topic.posts.as_feed(params.slice(:limit, :before))
      render json: PostPresenter.array(posts).map(&:with_parents)
    end

    def join
      topic.user_join(@current_user)
      render json: true
    end

    def leave
      topic.user_leave(@current_user)
      render json: true
    end

    private

    def topic
    	@topic ||= Topic.find(params[:id])
    end
  end
end