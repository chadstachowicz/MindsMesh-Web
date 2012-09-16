class AddAttachmentImageFileToPostAttachments < ActiveRecord::Migration
  def self.up
    change_table :post_attachments do |t|
      t.has_attached_file :file
    end
  end

  def self.down
    drop_attached_file :post_attachments, :file
  end
end
