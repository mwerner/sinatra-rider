# Warden
require 'warden'
require 'sinatra_warden'

Warden::Manager.serialize_into_session{|user| user.id }
Warden::Manager.serialize_from_session{|id| User.find(id) }

Warden::Strategies.add(:password) do
  def valid?
    params["username"] || params["password"]
  end

  def authenticate!
    auth = User.authenticate(params["username"], params["password"])
    auth.nil? ? fail!("Could not log in") : success!(auth)
  end
end

module Sinatra
  module Rider
    module Authentication
      def self.registered(app)
        app.register Sinatra::Warden
        app.use Rack::Session::Cookie, secret: ENV['SESSION_SECRET'] || "I'm not a businessman. I'm a business, man."
        app.use ::Warden::Manager do |manager|
          manager.default_strategies :password
          manager.failure_app = app
        end

        app.set :auth_template_renderer, :erb
        app.set :auth_success_path, '/'
        app.set :auth_failure_path, '/login'

        app.get '/login' do
          erb :login
        end

        app.post '/login' do
          env['warden'].authenticate!
        end

        app.get '/logout' do
          env['warden'].logout
        end
      end
    end
  end
end
