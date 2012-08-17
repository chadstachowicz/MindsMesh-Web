module Api::V1
  class EntityPresenter < BasePresenter

    def as_json(options={})
      m.as_json(options)
    end

    def with_entity_user_and_topics(current_user)
      a_entity_user = EntityUser.where(user_id: current_user.id, entity_id: m.id)
      a_topic_users = TopicUser.where(user_id: current_user.id, topic_id: m.topic_ids).pluck(:topic_id)

      as_json.merge({
        entity_user: a_entity_user,
        topics: m.topics.map { |t|
          t.as_json.merge({
            b_joined: a_topic_users.include?(t.id)
          })
        }
      })
    end

  end
end