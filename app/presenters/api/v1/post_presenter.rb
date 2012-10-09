module Api::V1
  class PostPresenter < BasePresenter

    def as_json(options={})
      m.as_json(options)
    end

    def with_parents
      as_json.merge({
        user:  UserPresenter.new(m.user),
        topic: TopicPresenter.new(m.topic)
      })
    end

    def with_children
      as_json.merge({
        post_attachments: PostAttachmentPresenter.array(m.post_attachments).to_json,
        replies: m.replies.map { |r| r.as_json.merge({ user: UserPresenter.new(r.user) }) }
      })
    end

  end
end