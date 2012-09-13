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
      render json: EntityPresenter.array(entities).map { |ep| ep.with_entity_user_and_topics(@current_user) }
    end

    def topics
      topics = @current_user.topics
      render json: TopicPresenter.array(topics)
    end

    def search_topics
      topics = @current_user.search_topics(params[:q])
      render json: TopicPresenter.array(topics)
    end

    def create_entity_request
      entity_uncc = Entity.find_by_slug('uncc')
      eur = @current_user.entity_user_requests.where(entity_id: entity_uncc.id, email: params[:email]).first_or_initialize
      eur.generate_and_mail_new_token
      text = eur.save ? "a confirmation email has been sent to #{params[:email]}" : eur.errors.full_messages.to_sentence.to_s
      render json: {message: text}
    end

  end
end