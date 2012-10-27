env :PATH, ENV['PATH']
set :output, "#{path}/log/cron.log"

every :reboot do
  command "cd :path && RAILS_ENV=:environment bundle exec ruby script/stalker_daemon restart :output"
  command "cd :path && bundle exec rapns :environment"
end

# Learn more: http://github.com/javan/whenever