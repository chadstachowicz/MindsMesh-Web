class V1::PostPresenter < V1::BasePresenter

  def as_json(options={})
    m.as_json(options)
  end

  def with_includes
    as_json.merge({
      user: V1::UserPresenter.new(m.user),
      topic: V1::TopicPresenter.new(m.topic)
    })
  end

end
