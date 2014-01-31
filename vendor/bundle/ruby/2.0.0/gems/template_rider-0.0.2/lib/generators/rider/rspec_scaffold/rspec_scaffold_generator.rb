module Rider
  class RspecScaffoldGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def copy_template
      template_subpath = "generators/rspec/scaffold/templates/"
      overrider_path = "lib/templates/rspec/scaffold/"

      rails_path = `gem which rspec-rails`
      template_path = rails_path.gsub("rspec-rails.rb\n", template_subpath)
      
      available_files.each do |file_name|
        template_file  = File.join(template_path, "#{file_name}_spec.rb")
        overrider_file = File.join(overrider_path, "#{file_name}_spec.rb")
        copy_file template_file, overrider_file
      end
    end

    protected

    def available_files
      %w(index edit show new routing controller)
    end
  end
end
