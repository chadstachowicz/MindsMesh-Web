class V1::PostPresenter < V1::BasePresenter

  def as_json(options={})
    m.as_json(options)
  end

  def with_parents
    as_json.merge({
      user: V1::UserPresenter.new(m.user),
      topic: V1::TopicPresenter.new(m.topic)
    })
  end

  def with_children
    as_json.merge({
      replies: m.replies.map { |r| r.as_json.merge({ user: V1::UserPresenter.new(r.user) }) }
    })
  end

end
