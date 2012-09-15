env :PATH, ENV['PATH']
set :output, "#{path}/log/cron.log"

job_type :script,  "cd :path && RAILS_ENV=:environment bundle exec ruby script/:task :output"

every 2.minutes do
  rake "when:2minutes"
end

every :reboot do
  script "stalker_daemon restart"
end

# Learn more: http://github.com/javan/whenever