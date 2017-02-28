require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'sinatra/activerecord/rake'

RSpec::Core::RakeTask.new(:spec)

namespace :db do
  task :load_config do
    require "sinatra/rider"

    class TestServer < Sinatra::Base
      register Sinatra::Rider
    end
  end
end

task :default => :spec
