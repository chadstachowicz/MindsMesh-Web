module Api::V1
  class NotificationPresenter < BasePresenter

    def self.array(models)
      a = models.map { |m| NotificationPresenter.new m }
      ArrayPresenter.new(a)
    end

    def as_json(options={})
      m.as_json(except: [:updated_at, :fb_apprequest_id])
    end

    def with_parents
      as_json.merge({
        user:  UserPresenter.new(m.user)
      })
    end
    
  end
end
