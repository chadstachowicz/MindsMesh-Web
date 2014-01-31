class AddPrivacyToTopics < ActiveRecord::Migration
  def change
      add_column :topics, :privacy, :integer, :default => 0
  end
end
