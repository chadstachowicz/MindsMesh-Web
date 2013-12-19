# This file is used by Rack-based servers to start the application.
require 'resque/server'
require 'rails'
require 'rack'
require ::File.expand_path('../config/environment',  __FILE__)

use Rails::Rack::LogTailer

use Rack::ShowExceptions

AUTH_PASSWORD = 'secret'
if AUTH_PASSWORD
  Resque::Server.use Rack::Auth::Basic do |username, password|
    password == AUTH_PASSWORD
  end
end

app = Rack::Builder.new {

  map "/resque" do
    run Resque::Server
  end

  map "/" do
    run ActionController::Routing::RouteSet::Dispatcher.new
  end
}.to_app

run app


run Mindsmesh::Application