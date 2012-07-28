env :PATH, ENV['PATH']
set :output, "#{path}/log/cron.log"

every 2.minutes do
  rake "when:2minutes"
end

# Learn more: http://github.com/javan/whenever