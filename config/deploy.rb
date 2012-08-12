require "bundler/capistrano"
load "config/recipes/db_backups"

role :web, "50.116.44.225"
role :app, "50.116.44.225"
role :db,  "50.116.44.225", primary: true

set :application, "mindsmesh"
set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:yakko/#{application}.git"
set :branch, "master"

#custom begin
set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"
=begin
require "delayed/recipes"
set :rails_env, "production" #added for delayed job
after "deploy:stop",    "delayed_job:stop"
after "deploy:start",   "delayed_job:start"
after "deploy:restart", "delayed_job:restart"
=end
#custom end

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do

  #extracted from https://github.com/capistrano/capistrano/blob/master/lib/capistrano/recipes/deploy/assets.rb#L31
  namespace :assets do

    def remote_file_exists?(full_path)
      'true' ==  capture("if [ -e #{full_path} ]; then echo 'true'; fi").strip
    end
  
    desc <<-DESC
      Run the asset precompilation rake task. You can specify the full path \
      to the rake executable by setting the rake variable. You can also \
      specify additional environment variables to pass to rake via the \
      asset_env variable. The defaults are:

        set :rake,      "rake"
        set :rails_env, "production"
        set :asset_env, "RAILS_GROUPS=assets"
      Mindsmesh custom: will not precompile files that are already precompiled
    DESC
    task :precompile, :roles => assets_role, :except => { :no_release => true } do
      
      my_cap_setings = YAML.load(File.read("config/mindsmesh.cap.yml"))
      assets_version_touch_filename = "#{shared_path}/assets/#{my_cap_setings['assets_version']}.touch"
      #
      #if File.exist?(assets_version_touch_filename)
      if remote_file_exists?(assets_version_touch_filename)
        puts "Assets seem to be precompiled already. config/mindsmesh.cap.yml : #{my_cap_setings['assets_version']}"
      else
        run <<-CMD
          cd #{latest_release} &&
          #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile &&
          touch #{assets_version_touch_filename}
        CMD
      end
    end

  end


  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.yml.example"), "#{shared_path}/config/database.yml"
    put File.read("config/settings.yml.example"), "#{shared_path}/config/settings.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/settings.yml #{release_path}/config/settings.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end