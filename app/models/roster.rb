class Roster < ActiveRecord::Base
    attr_accessible :email, :group_id, :topic_id, :user_id, :role
    
  def self.import(file)
    job = BackgroundJob.create(:name => "ImportRosters", :status => 'Processing')
    n = SmarterCSV.process(file.tempfile.to_path.to_s, {:chunk_size => 100}) do |chunk|
        Resque.enqueue( ImportRosters, chunk, job.id ) # pass chunks of CSV-data to Resque workers for parallel processing
    end
    job.total_records = n
    job.save

end
end
