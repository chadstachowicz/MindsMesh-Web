module Rider
  class HamlScaffoldGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def validates_required_gems
      begin
        require 'haml-rails'
      rescue LoadError
        s = "Add to Gemfile: gem 'haml-rails'"
        5.times { puts s }
        raise s
      end
    end

    def copy_template
      template_subpath = "lib/generators/haml/scaffold/templates/"
      overrider_path = "lib/templates/haml/scaffold/"

      haml_rails_path = `gem which haml-rails`
      template_path = haml_rails_path.gsub("lib/haml-rails.rb\n", template_subpath)
      
      available_views.each do |view|
        template_file  = File.join(template_path, "#{view}.html.haml")
        overrider_file = File.join(overrider_path, "#{view}.html.haml")
        copy_file template_file, overrider_file
      end
    end

    protected

    def available_views
      %w(index edit show new _form)
    end
    
  end
end
