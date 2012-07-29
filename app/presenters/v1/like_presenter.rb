class V1::LikePresenter < V1::BasePresenter

  def as_json(options={})
    m.as_json(options)
  end

  def with_parents
    as_json.merge({
      user: V1::UserPresenter.new(m.user)
    })
  end

end
