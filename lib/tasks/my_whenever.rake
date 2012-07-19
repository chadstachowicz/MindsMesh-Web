namespace :when do

  def now
    Time.now.strftime('%H:%M:%S')
  end

  desc "sample"
  task '2minutes' => :environment do
    i = rand 99999
  	puts "#BEGIN 2 minutes: #{now} ##{i}"
  	Notify.run_all %w(Reply Like)
    puts "#END   2 minutes: #{now} ##{i}"
  end

  desc "sample"
  task '6hours' => :environment do
    i = rand 99999
    puts "#BEGIN 6 hours: #{now} ##{i}"
    Notify.run_all %w(Post)
    puts "#END   6 hours: #{now} ##{i}"
  end

end