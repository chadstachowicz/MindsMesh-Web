namespace :rapns do
  desc "restarts beanstalkd"
  task :start do
    run "cd #{current_path} && bundle exec rapns #{my_rails_env}"
  end
end