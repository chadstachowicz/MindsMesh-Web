class AddTitleAndNumberToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :title, :string
    add_column :topics, :number, :string
  end
end
