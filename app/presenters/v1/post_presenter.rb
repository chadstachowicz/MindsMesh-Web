class V1::PostPresenter < V1::BasePresenter

  def as_json(options={})
    m.as_json(options)
  end

end
