if Rails.env.production?
  ENV["REDISTOGO_URL"] ||= "redis://:g6YHMonCREUTLfBCdcUMrYoTV7uOHsVkdVMNmFUGZyxmAn7Kg66qWgCaPgv7ILLt@54.235.176.92:11424/"
else
  ENV["REDISTOGO_URL"] ||= "redis://:g6YHMonCREUTLfBCdcUMrYoTV7uOHsVkdVMNmFUGZyxmAn7Kg66qWgCaPgv7ILLt@proxy.openredis.com:11424/"
end
uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)
