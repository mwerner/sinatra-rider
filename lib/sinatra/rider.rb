ENV['RACK_ENV'] ||= 'development'
require 'dotenv'
Dotenv.load

require 'active_record'
require 'sinatra/base'
require 'sinatra/activerecord'

require 'sinatra/rider/assets'
require 'sinatra/rider/authentication'
require 'sinatra/rider/configuration'
require 'sinatra/rider/pathing'
require 'sinatra/rider/version'

module Sinatra
  module Rider
    autoload :User, 'sinatra/rider/user'

    def self.registered(app)
      app.set :database_file, File.join(app.root, "config/database.yml").to_s

      %w(app lib).map do |path|
        Dir.glob("#{File.join(app.root, path)}/*.rb").each { |file| require file }
      end

      app.register Sinatra::ActiveRecordExtension
      app.register Sinatra::Rider::Assets
      app.register Sinatra::Rider::Authentication
      app.register Sinatra::Rider::Configuration
      app.register Sinatra::Rider::Pathing
    end
  end
end
