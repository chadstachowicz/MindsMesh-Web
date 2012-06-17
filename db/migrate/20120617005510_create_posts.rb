class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :section
      t.references :user
      t.text :text

      t.timestamps
    end
    add_index :posts, :section_id
    add_index :posts, :user_id
  end
end
