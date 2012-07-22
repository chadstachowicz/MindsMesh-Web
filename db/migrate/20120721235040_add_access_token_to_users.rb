class AddAccessTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :access_token, :string
    User.all.map(&:change_access_token)
  end
end
