class Add < ActiveRecord::Migration
  def up
      create_table :hashtags_posts do |t|
          t.integer :post_id
          t.integer :hashtag_id
          
          t.timestamps
      end
  end

  def down
  end
end
