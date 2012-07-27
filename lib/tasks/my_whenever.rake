namespace :when do

  desc "sample"
  task '2minutes' => :environment do
  	Notify.run_all %w(Reply Like Post)
  end

end