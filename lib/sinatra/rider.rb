ENV['RACK_ENV'] ||= 'development'
require 'bundler'
Bundler.load

require 'dotenv'
Dotenv.load

require 'active_record'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/rider/version'
require 'sinatra/rider/authentication'
require 'sinatra/rider/configuration'
require 'sinatra/rider/asset_pipeline'

module Sinatra
  module Rider
    def self.registered(app)
      caller = Kernel.caller_locations.detect { |file| file.absolute_path =~ /config\.ru/ }
      Sinatra::Rider.root = Pathname.new(caller.absolute_path).dirname

      %w(app lib).map do |path|
        Dir.glob("#{File.join(Sinatra::Rider.root, path)}/*.rb").each { |file| require file }
      end

      app.register Sinatra::ActiveRecordExtension
      app.register Sinatra::Rider::Authentication
      app.register Sinatra::Rider::AssetPipeline
      app.register Sinatra::Rider::Configuration

      app.set :database_file, File.join(Sinatra::Rider.root, "config/database.yml").to_s
    end

    def self.root=(path)
      @@root = path
    end

    def self.root
      @@root
    end
  end
end
