# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rspec', :version => 2, :cli => '--drb' do
=begin
  watch(%r{^spec/.+_spec\.rb$})
  watch('spec/spec_helper.rb')  { "spec" }

  # Rails example

  # too generic
  #watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  #watch(%r{^app/(.*)(\.erb|\.haml)$})                 { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }

  # not used
  #watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  #watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }


  # routes
  watch('config/routes.rb')                   { "spec/routing" }
  watch(%r{^spec/routing/(.+)_routing\.rb$})  { |m| "spec/routing/#{m[1]}_routing_spec.rb" }
  
  # models
  watch(%r{^app/models/(.+)\.rb$})    { |m| "spec/models/#{m[1]}_spec.rb" }
  
  # controllers
  watch(%r{^app/controllers/(.+)_controller\.rb$})    { |m| "spec/#{m[1]}_controller_spec.rb" }
=end
  #requests
  watch(%r{^spec/requests/(.+)_spec\.rb$}) { |m| ["spec/requests/#{m[1]}_spec.rb"] }
=begin
  #views
  watch(%r{^app/views/(.+)/.*\.(erb|haml)$})     { |m| ["spec/views/#{m[1]}_spec.rb"] }
=end
end

