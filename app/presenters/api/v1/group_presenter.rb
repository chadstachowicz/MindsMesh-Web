module Api::V1
  class GroupPresenter < BasePresenter

    def as_json(options={})
      m.as_json(options)
    end

  end
end