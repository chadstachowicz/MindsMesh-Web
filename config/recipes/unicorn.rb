set_default(:unicorn_user)    { user }
set_default(:unicorn_pid)     { "#{current_path}/tmp/pids/unicorn.pid" }
set_default(:unicorn_config)  { "#{shared_path}/config/unicorn.rb" }
set_default(:unicorn_log)     { "#{shared_path}/log/unicorn.log" }
set_default(:unicorn_workers, 2)

namespace :unicorn do
  desc "Setup Unicorn initializer and app configuration"
  task :setup, roles: :app do
    run "mkdir -p #{shared_path}/config"
    template "config_unicorn.rb.erb", unicorn_config
    #
    tmp_file = "/tmp/unicorn_init_#{application}"
    template "unicorn_init.erb", tmp_file
    run "chmod +x #{tmp_file}"
    run "#{sudo} mv #{tmp_file} /etc/init.d/unicorn_#{application}"
    run "#{sudo} update-rc.d -f unicorn_#{application} defaults"
  end
end