class CreateMessageAttachments < ActiveRecord::Migration
  def change
    create_table :message_attachments do |t|
      t.integer :message_id
      t.string :subtype
      t.string :link_url
      t.string :file_file_name
      t.string :file_content_type
      t.integer :file_file_size
      t.datetime :file_updated_at

      t.timestamps
    end
    add_index "message_attachments", ["message_id"], :name => "index_message_attachments_on_message_id"
  end
end
