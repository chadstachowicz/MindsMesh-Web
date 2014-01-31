class CreateInviteRequests < ActiveRecord::Migration
  def change
    create_table :invite_requests do |t|
      t.references :user
      t.references :entity
      t.references :topic

      t.timestamps
    end
    add_index :invite_requests, :user_id
    add_index :invite_requests, :entity_id
    add_index :invite_requests, :topic_id
  end
end
