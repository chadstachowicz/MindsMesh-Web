class AddTokenToInviteRequest < ActiveRecord::Migration
  def change
       add_column :invite_requests, :confirmation_token, :string
  end
end
