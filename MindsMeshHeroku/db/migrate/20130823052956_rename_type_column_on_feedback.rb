class RenameTypeColumnOnFeedback < ActiveRecord::Migration
  def up
      rename_column :feedback_bugs, :type, :request_type
  end

  def down
  end
end
