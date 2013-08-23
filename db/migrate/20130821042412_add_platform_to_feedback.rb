class AddPlatformToFeedback < ActiveRecord::Migration
  def change
      add_column :feedback_bugs, :platform, :string
  end
end
