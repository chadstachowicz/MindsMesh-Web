class AddEntityUsersCountToEntitiesAndUsers < ActiveRecord::Migration
  def up
    add_column :entities, :entity_users_count, :integer
    add_column :entities, :topics_count, :integer
    add_column :users, :entity_users_count, :integer
    Entity.all.each do |e|
      Entity.update_counters e.id, entity_users_count: e.entity_users.length,
                                   topics_count:       e.topics.length
    end
    User.all.each do |u|
      User.update_counters u.id, entity_users_count: u.entity_users.length
    end
  end
  def down
    remove_column :entities, :entity_users_count
    remove_column :entities, :topics_count
    remove_column :users, :entity_users_count
  end
end
