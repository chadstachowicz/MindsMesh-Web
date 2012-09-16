class CreatePostAttachments < ActiveRecord::Migration
  def change
    create_table :post_attachments do |t|
      t.references :post
      t.string :subtype
      t.string :link_url

      t.timestamps
    end
    add_index :post_attachments, :post_id
  end
end
