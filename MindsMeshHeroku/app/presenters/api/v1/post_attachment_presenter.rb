module Api::V1
  class PostAttachmentPresenter < BasePresenter

    def self.array(models)
      a = models.map { |m| PostAttachmentPresenter.new m }
      ArrayPresenter.new(a)
    end

    def as_json(options={})
      {
        id:       m.id,
        name:     m.file_file_name,
        ext_path: m.ext_path,
        url:      m.file.url,
        subtype:  m.subtype
      }
    end

  end
end
