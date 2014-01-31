class CreateRosters < ActiveRecord::Migration
  def change
    create_table :rosters do |t|
      t.string :email
      t.integer :topic_id
      t.integer :group_id
      t.integer :user_id

      t.timestamps
    end
  end
end
