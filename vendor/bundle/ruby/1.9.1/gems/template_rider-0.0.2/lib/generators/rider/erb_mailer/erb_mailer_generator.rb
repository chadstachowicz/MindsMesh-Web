module Rider
  class ErbMailerGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def copy_template
      template_subpath = "rails/generators/erb/mailer/templates/view.text.erb"
      overrider_path = "lib/templates/erb/mailer/view.text.erb"

      rails_path = `gem which rails`
      template_path = rails_path.gsub("rails.rb\n", template_subpath)
      
      copy_file template_path, overrider_path
    end
  end
end
