module Api::V1
  class LikePresenter < BasePresenter

    def as_json(options={})
      m.as_json(options)
    end

    def with_parents
      as_json.merge({
        user: UserPresenter.new(m.user)
      })
    end

  end
end