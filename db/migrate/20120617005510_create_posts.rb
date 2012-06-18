class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :section
      t.references :user
      t.references :section_user
      t.text :text

      t.timestamps
    end
    add_index :posts, :section_id
    add_index :posts, :user_id
    add_index :posts, :section_user_id
  end
end
