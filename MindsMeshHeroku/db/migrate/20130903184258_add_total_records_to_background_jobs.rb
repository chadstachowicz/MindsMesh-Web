class AddTotalRecordsToBackgroundJobs < ActiveRecord::Migration
  def change
      add_column :background_jobs, :total_records, :integer
  end
end
