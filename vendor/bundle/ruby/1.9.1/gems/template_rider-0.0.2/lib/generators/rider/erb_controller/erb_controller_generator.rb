module Rider
  class ErbControllerGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
      
    def copy_template_controller
  
      template_subpath = "rails/generators/rails/controller/templates/controller.rb"
      overrider_path = "lib/templates/rails/controller/controller.rb"

      rails_path = `gem which rails`
      template_path = rails_path.gsub("rails.rb\n", template_subpath)

      copy_file template_path, overrider_path
    end
    
    def copy_template_view
      template_subpath = "rails/generators/erb/controller/templates/view.html.erb"
      overrider_path = "lib/templates/erb/controller/view.html.erb"

      rails_path = `gem which rails`
      template_path = rails_path.gsub("rails.rb\n", template_subpath)

      copy_file template_path, overrider_path
    end
  end
end
