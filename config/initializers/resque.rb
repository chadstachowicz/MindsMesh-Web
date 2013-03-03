ENV["REDISTOGO_URL"] ||= "redis://:g6YHMonCREUTLfBCdcUMrYoTV7uOHsVkdVMNmFUGZyxmAn7Kg66qWgCaPgv7ILLt@54.235.176.92:11424/"

uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)