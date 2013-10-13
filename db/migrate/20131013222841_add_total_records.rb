class AddTotalRecords < ActiveRecord::Migration
  def up
      add_column :background_jobs, :total_records, :integer
  end

  def down
  end
end
