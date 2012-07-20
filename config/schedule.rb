env :PATH, ENV['PATH']
set :output, "#{path}/log/cron.log"

every 2.minutes do
  rake "when:2minutes"
end

every 30.minutes do
  rake "when:30minutes"
end

# Learn more: http://github.com/javan/whenever