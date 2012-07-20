namespace :when do

  def now
    Time.now.strftime('%H:%M:%S')
  end

  desc "sample"
  task '2minutes' => :environment do
    i = rand 99999
  	puts "#BEGIN 02 minutes: #{now} ##{i}"
  	Notify.run_all %w(Reply Like)
    puts "#END   02 minutes: #{now} ##{i}"
  end

  desc "sample"
  task '30minutes' => :environment do
    i = rand 99999
    puts "#BEGIN 30 minutes: #{now} ##{i}"
    Notify.run_all %w(Post)
    puts "#END   30 minutes: #{now} ##{i}"
  end

end