namespace :nginx do

  desc "Setup nginx configuration for this application"
  task :setup, roles: :web do
    tmp_file = "/tmp/nginx_conf_#{application}"
    template "nginx_unicorn.erb", tmp_file
    run "#{sudo} mv #{tmp_file} /etc/nginx/sites-enabled/#{application}"
    run "#{sudo} rm -f /etc/nginx/sites-enabled/default"
    restart #invokes restart task below
  end
  
  %w[start stop restart].each do |command|
    desc "#{command} nginx"
    task command, roles: :web do
      run "#{sudo} service nginx #{command}"
    end
  end
end