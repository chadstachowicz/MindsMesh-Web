class Roster < ActiveRecord::Base
  attr_accessible :email, :group_id, :topic_id, :user_id
    
  def self.import(file)
    n = SmarterCSV.process(file.tempfile.to_path.to_s, {:chunk_size => 5}) do |chunk|
    Resque.enqueue( ImportRosters, chunk ) # pass chunks of CSV-data to Resque workers for parallel processing
  end

end
end
