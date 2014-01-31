module Rider
  class ScaffoldControllerGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def copy_template
      template_subpath = "rails/generators/rails/scaffold_controller/templates/controller.rb"
      overrider_path = "lib/templates/rails/scaffold_controller/controller.rb"
      
      rails_path = `gem which rails`
      template_path = rails_path.gsub("rails.rb\n", template_subpath)
      
      copy_file template_path, overrider_path
    end
  end
end
