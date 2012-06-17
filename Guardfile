# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rspec', :version => 2, :cli => '--drb' do
  watch(%r{^spec/.+_spec\.rb$})
  watch('spec/spec_helper.rb')  { "spec" }

  # Rails example
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(\.erb|\.haml)$})                 { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }

  # controllers
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| [
                                             "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb",
                                             "spec/requests/#{m[1]}_spec.rb"
                                             ] }
                                             #,"spec/acceptance/#{m[1]}_spec.rb"

  # not used
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }

  # routes
  watch('config/routes.rb')                           { "spec/routing" }
  
  # controllers
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }
  watch('app/models/ability.rb')  { "spec/controllers" }
  
  # view and request
  watch('spec/my_capybara_helper.rb')            { "spec/requests" }
  watch(%r{^spec/requests/(.+)/.*\.(erb|haml)$}) { |m| [
                                                        "spec/requests/#{m[1]}_spec.rb",
                                                        "spec/views/#{m[1]}_spec.rb"
                                                        ] }
  watch(%r{^app/views/(.+)/.*\.(erb|haml)$})     { |m| [
                                                        "spec/requests/#{m[1]}_spec.rb",
                                                        "spec/views/#{m[1]}_spec.rb"
                                                        ] }
end

