module Api::V1
  class HomeController < BaseController

    def posts
      posts = @current_user.posts_feed(params.slice(:limit, :before))
      render json: PostPresenter.array(posts)
    end

    def posts_with_parents
      posts = @current_user.posts_feed(params.slice(:limit, :before))
      render json: PostPresenter.array(posts).map(&:with_parents)
    end

    def entities
      entities = @current_user.entities
      render json: EntityPresenter.array(entities)
    end

    def entities_with_children
      entities = @current_user.entities
      render json: EntityPresenter.array(entities).map { |ep| ep.with_topics_and_topic_users(@current_user) }
    end

    def topics
      topics = @current_user.topics
      render json: TopicPresenter.array(topics)
    end

    def search_topics
      topics = @current_user.search_topics(params[:q])
      render json: TopicPresenter.array(topics)
    end

  end
end