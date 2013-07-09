class CreatePostHashtags < ActiveRecord::Migration
  def change
    create_table :post_hashtags do |t|
      t.integer :post_id
      t.integer :hashtag_id

      t.timestamps
    end
  end
end
