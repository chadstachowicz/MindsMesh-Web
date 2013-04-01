class ChangeGroupUsers < ActiveRecord::Migration
    def change
        remove_column :group_users, :topic_id
        add_column :group_users, :group_id, :integer
    end
end
