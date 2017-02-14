module Sinatra
  module Rider
    module Configuration
      def self.registered(app)
        app.configure :development do
          require 'sinatra/rider/quiet_assets'
          require 'sinatra/reloader'
          require 'better_errors'

          app.register Sinatra::Rider::QuietAssets
          app.register Sinatra::Reloader

          %w(app lib).each do |dir|
            Dir.glob("#{File.join(app.root, dir)}/*.rb").each do |file|
              app.also_reload file
            end
          end

          app.use BetterErrors::Middleware
          BetterErrors.application_root = app.root
        end
      end
    end
  end
end
