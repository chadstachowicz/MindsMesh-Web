namespace :stalker do
  desc "restarts beanstalkd"
  task :restart do
    basic_command = "cd #{current_path} && RAILS_ENV=#{my_rails_env} bundle exec ruby script/stalker_daemon"
    run "#{basic_command} stop"
    run "#{basic_command} start"
  end
end