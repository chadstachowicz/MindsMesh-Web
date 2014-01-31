class MessageAttachments < ActiveRecord::Base
    belongs_to :message
  attr_accessible :file_content_type, :file_file_name, :file_file_size, :file_updated_at, :link_url, :message_id, :subtype
end
