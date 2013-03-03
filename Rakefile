#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'resque/tasks'
require 'rack'
require 'rails'

task "resque:preload" => :environment
task "resque:setup" do
      ENV['QUEUE'] ||= '*'
      Resque.before_fork = Proc.new { ActiveRecord::Base.establish_connection }
end

task "jobs:work" => "resque:work"

Mindsmesh::Application.load_tasks
