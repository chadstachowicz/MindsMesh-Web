class CreateGroupUsers < ActiveRecord::Migration
  def change
    create_table :group_users do |t|
      t.integer :topic_id
      t.integer :user_id
      t.integer :role_i

      t.timestamps
    end
  end
end
