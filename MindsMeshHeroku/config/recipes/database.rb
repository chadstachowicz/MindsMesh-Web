namespace :database do

  task :override_database_yml, roles: :app do
    db_yml_file = "#{release_path}/config/database.yml"
    run "rm #{db_yml_file}"
    template "database.yml.erb", db_yml_file
    #
    db_yml_file = "#{release_path}/config/settings.yml"
    run "rm #{db_yml_file}"
    template "settings.yml.erb", db_yml_file
  end

end