module Api::V1
  class EntityPresenter < BasePresenter

    def as_json(options={})
      m.as_json(options)
    end

    def with_topics_and_topic_users(current_user)
      a_topic_users = TopicUser.where(user_id: current_user.id, topic_id: m.topic_ids).pluck(:topic_id)

      as_json.merge({
        topics: m.topics.map { |t|
          t.as_json.merge({
            b_joined: a_topic_users.include?(t.id)
          })
        }
      })
    end

  end
end