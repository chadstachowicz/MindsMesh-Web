class CreateLoginLogs < ActiveRecord::Migration
  def change
    create_table :login_logs do |t|
      t.references :user
      t.string :user_agent

      t.timestamps
    end
    add_index :login_logs, :user_id

    add_column :users, :last_login_at, :datetime
    User.update_all last_login_at: 1.year.ago
  end
end
