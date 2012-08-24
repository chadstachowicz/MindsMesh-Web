namespace :db do

  def set_backup_path_for(db_name)
    run "mkdir -p #{shared_path}/db_backups"
    backup_time = Time.now.strftime('%Y%m%d_%H%M%S')
    set :backup_filename, "#{db_name}-snapshot-#{backup_time}.sql"
    set :backup_path, "#{shared_path}/db_backups/#{backup_filename}"
  end

  desc "Backup your MySQL or PostgreSQL database to shared_path+/db_backups"
  task :dump, :roles => :db, :only => {:primary => true} do
    run("cat #{shared_path}/config/database.yml") { |channel, stream, data| @environment_info = YAML.load(data)[rails_env] }
    dbuser = @environment_info['username']
    dbpass = @environment_info['password']
    environment_database = @environment_info['database']
    set_backup_path_for(@environment_info['database'])

    dbhost = @environment_info['host']
    if @environment_info['adapter'] == 'mysql'
      run "mysqldump --add-drop-table -u #{dbuser} -h #{dbhost} -p #{environment_database} | bzip2 -c > #{backup_path}.bz2" do |ch, stream, out |
        ch.send_data "#{dbpass}\n" if out=~ /^Enter password:/
      end
    else
      run "pg_dump -W -c -U #{dbuser} -h #{dbhost} #{environment_database} | bzip2 -c > #{backup_path}.bz2" do |ch, stream, out |
        ch.send_data "#{dbpass}\n" if out=~ /^Password:/
      end
    end
  end

  desc "Backup on server, then downloads locally"
  task :down, :roles => :db, :only => {:primary => true} do
    dump
    set :to_filename, "#{backup_filename}.bz2"
    get "#{backup_path}.bz2", to_filename
    puts "download finished to #{to_filename}"
  end
  
  desc "Sync your production database to your local workstation"
  task :import, :roles => :db, :only => {:primary => true} do
    down

    development_info = YAML.load_file("config/database.yml")['development']
    if development_info['adapter'] == 'mysql'
      run_str = "bzcat #{backup_filename}.bz2 | mysql -u #{development_info['username']} --password='#{development_info['password']}' -h #{development_info['host']} #{development_info['database']}"
    else
      run_str = "PGPASSWORD=#{development_info['password']} bzcat #{backup_filename}.bz2 | psql -U #{development_info['username']} -h #{development_info['host']} #{development_info['database']}"
    end

    puts "restoring..."
    %x!#{run_str}!
    puts "done!"
  end

end