module Rider
  class ErbScaffoldGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def copy_template
      template_subpath = "rails/generators/erb/scaffold/templates/"
      overrider_path = "lib/templates/erb/scaffold/"

      rails_path = `gem which rails`
      template_path = rails_path.gsub("rails.rb\n", template_subpath)
      
      available_views.each do |view|
        template_file  = File.join(template_path, "#{view}.html.erb")
        overrider_file = File.join(overrider_path, "#{view}.html.erb")
        copy_file template_file, overrider_file
      end
    end

    protected

    def available_views
      %w(index edit show new _form)
    end
    
  end
end
