def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), to
end

#similar to _cset
def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end




namespace :deploy do

  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "#{sudo} service unicorn_#{application} #{command}"
    end
  end

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/#{branch}`
      puts "WARNING: HEAD is not the same as origin/#{branch}"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  
end





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

end