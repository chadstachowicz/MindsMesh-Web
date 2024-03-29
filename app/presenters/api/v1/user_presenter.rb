module Api::V1
  class UserPresenter < BasePresenter

    def as_json(options={})
      #m.as_json(options)
      {
      	id:     m.id,
      	gender: m.gender,
      	name:   m.name,
      	role:   m.role,
      	posts_count: m.posts_count,
      	photo_url: m.photo_url
      }
    end

    def with_children
      as_json.merge({
        topic_users: m.topic_users.map { |tu| tu.as_json.merge({ topic: TopicPresenter.new(tu.topic) }) },
        entity_users: m.entity_users.map { |eu| eu.as_json.merge({ entity: EntityPresenter.new(eu.entity) }) },
        group_users: m.group_users.map { |gu| gu.as_json.merge({ group: GroupPresenter.new(gu.group) }) }
      })
    end

    def as_me
      {access_token: m.access_token}.merge(with_children)
    end
    
  end
end