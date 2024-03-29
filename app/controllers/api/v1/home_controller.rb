
# MindsMesh (c) 2013

module Api::V1
  class HomeController < BaseController

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
    
    #  post "/home/entities" => "home#create_entity_request"
    # link an account to an entity   
    def create_entity_request
      entity = Entity.find_by_email_domain(params[:email])
      eur = @current_user.entity_user_requests.where(entity_id: entity.id, email: params[:email]).first_or_initialize
      eur.generate_and_mail_new_token
      text = eur.save ? "a confirmation email has been sent to #{params[:email]}" : eur.errors.full_messages.to_sentence.to_s
      render json: {message: text}
    end

    #POST /home/register_device
    def register_device
      ud = @current_user.user_devices.where(token: params[:token]).first_or_initialize
      ud.os = params[:os]
      ud.environment = params[:environment]
      ud.name = params[:name]
      ud.model = params[:model]
      if ud.save
        render json: true
      else
        render json: {message: ud.errors.full_messages}
      end
    end

  end
end
