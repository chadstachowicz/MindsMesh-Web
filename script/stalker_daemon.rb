#!/usr/bin/env ruby
require 'rubygems'
require 'daemons'

pwd  = File.dirname(File.expand_path('..', __FILE__))
file = 'config/stalker_jobs.rb'
r_env = ENV['RAILS_ENV'] || 'development'

options = {
  :app_name => "stalker_mindsmesh_#{r_env}",
  :dir_mode => :normal,
  :dir => File.join(pwd, '/tmp/pids'),
  :backtrace => true,
  :monitor => true,
  :log_output => true,
  :log_dir => File.join(pwd, '/log')
}

Daemons.daemonize(options)

puts "-"
puts "-"*60
puts "STARTING DAEMON"
puts s = "#{`which stalk`.strip} #{pwd}/config/stalker_jobs.rb"
puts "-"*60
exec s