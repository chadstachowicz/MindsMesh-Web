require "bundler/capistrano"
require "capistrano_colors" # Color capistrano output for readability

%w[base database nginx unicorn stalker rapns db_backups].each do |recipe|
  load "config/recipes/#{recipe}"
end



# =============================================================================
# OPTIONAL VARIABLES
# =============================================================================
# ssh related
set :user, "deployer"
set :deploy_via, :remote_cache
set :use_sudo, false
# git related
set :scm, "git"
#multi-env related
set :application_name, 'mindsmesh'

# =============================================================================
# REQUIRED VARIABLES
# =============================================================================
set :repository, "git@github.com:chadstachowicz/#{application_name}.git"

# =============================================================================
# ROLES
# =============================================================================
server_ip = "ec2-54-243-246-106.compute-1.amazonaws.com"
role :web, server_ip                 # Your HTTP server, Apache/etc
role :app, server_ip                 # This may be the same as your `Web` server
role :db,  server_ip, primary: true  # This is where Rails migrations will run
#role :db,  "slave"








task :staging do
  set :my_rails_env, 'staging'
  #required var
  set :application, "#{application_name}_#{my_rails_env}"
  set :deploy_to, "/home/#{user}/apps/#{application}"
  set :branch, my_rails_env
  set :server_names,  'staging.mindsmesh.com'        # used in unicorn
  set :server_name,   server_names.split(' ').first  # used in the app where there's no request object
end

task :qa do
  set :my_rails_env, 'qa'
  #required var
  set :application, "#{application_name}_#{my_rails_env}"
  set :deploy_to, "/home/#{user}/apps/#{application}"
  set :branch, my_rails_env
  set :server_names,  'qa.mindsmesh.com'             # used in unicorn
  set :server_name,   server_names.split(' ').first  # used in the app where there's no request object
end

task :production do
  set :my_rails_env, 'production'
  #required var
  set :application, "#{application_name}_#{my_rails_env}"
  set :deploy_to, "/home/#{user}/apps/#{application}"
  set :branch, my_rails_env
  set :server_names,  'mindsmesh.com'             # used in unicorn
  set :server_name,   server_names.split(' ').first  # used in the app where there's no request object
end

task :check do
  puts "CHECK: #{application}"
end






default_run_options[:pty] = true
ssh_options[:forward_agent] = true






#custom begin
# set :whenever_command, "bundle exec whenever"
# require "whenever/capistrano"
=begin
require "delayed/recipes"
set :rails_env, "production" #added for delayed job
after "deploy:stop",    "delayed_job:stop"
after "deploy:start",   "delayed_job:start"
after "deploy:restart", "delayed_job:restart"
=end
#custom end








before "deploy",            "deploy:check_revision" #see recipes/base
before "deploy:migrations", "deploy:check_revision"
before "deploy:cold",       "deploy:check_revision"
before "deploy:setup",      "deploy:check_revision"


before "nginx:setup", "nginx:setup_ssl"
after 'deploy:setup', 'nginx:setup'   #see recipes/nginx
after "deploy:setup", "unicorn:setup" #see recipes/unicorn
after "deploy", "deploy:cleanup"      # keep only the last 5 releases

after "deploy", "stalker:restart"    #less commands finish faster
after "deploy:cold", "rapns:start" #doesnt need to restart, it doesnt change with the app's code
after "deploy:finalize_update", "database:override_database_yml" #see recipes/database