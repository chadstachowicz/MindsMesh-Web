class V1::UserPresenter < V1::BasePresenter

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
      topic_users: m.topic_users.map { |tu| tu.as_json.merge({ topic: V1::TopicPresenter.new(tu.topic) }) },
      entity_users: m.entity_users.map { |eu| eu.as_json.merge({ entity: V1::EntityPresenter.new(eu.entity) }) },
    })
  end

  def as_me
    {access_token: m.access_token}.merge(with_children)
  end
  
end
