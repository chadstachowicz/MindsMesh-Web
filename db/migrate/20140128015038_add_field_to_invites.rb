class AddFieldToInvites < ActiveRecord::Migration
  def change
      add_column :invite_requests, :invite_accepted, :integer
  end
end
