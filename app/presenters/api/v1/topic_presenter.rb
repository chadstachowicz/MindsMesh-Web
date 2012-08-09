module Api::V1
  class TopicPresenter < BasePresenter

    def as_json(options={})
      m.as_json(options)
    end

  end
end