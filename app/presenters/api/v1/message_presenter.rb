module Api::V1
  class MessagePresenter < BasePresenter

    def as_json(options={})
      {
      	id:     m.id,
      	text:   m.text,
        message_thread_id: m.message_thread_id
      }.merge({user: Api::V1::UserPresenter.new(m.user).as_json})
    end
    
  end
end