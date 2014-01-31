class CreateUserFollows < ActiveRecord::Migration
  def change
    create_table :user_follows do |t|
      t.integer :user_id
      t.integer :follow_id

      t.timestamps
    end
      add_index :user_follows, :user_id
      add_index :user_follows, :follow_id
  end
end
