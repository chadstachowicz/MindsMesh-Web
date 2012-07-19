set :output, "#{path}/log/cron.log"

every 2.minutes do
  rake "when:2minutes"
end

every 6.hours do
  rake "when:6hours"
end

# Learn more: http://github.com/javan/whenever