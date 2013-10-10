class AddFieldsToInvites < ActiveRecord::Migration
  def change
      add_column :invite_requests, :group_id, :integer
      add_column :invite_requests, :to_user_id, :integer
  end
end
