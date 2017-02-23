# Warden
require 'warden'
require 'sinatra_warden'

Warden::Manager.serialize_into_session{|user| user.id }
Warden::Manager.serialize_from_session do |id|
  auth_class = defined?(User) ? User : Sinatra::Rider::User
  auth_class.find(id)
end

Warden::Strategies.add(:password) do
  def valid?
    params["username"] || params["password"]
  end

  def authenticate!
    auth_class = defined?(User) ? User : Sinatra::Rider::User
    auth = auth_class.authenticate(params["username"], params["password"])
    auth.nil? ? fail!("Could not log in") : success!(auth)
  end
end

module Sinatra
  module Rider
    module AuthHelpers
      def signed_in?
        !current_user.nil?
      end
    end

    module Authentication
      def self.registered(app)
        app.register Sinatra::Warden
        app.helpers Sinatra::Rider::AuthHelpers
        app.use Rack::Session::Cookie, secret: ENV['SESSION_SECRET'] || "I'm not a businessman. I'm a business, man."
        app.use ::Warden::Manager do |manager|
          manager.default_strategies :password
          manager.failure_app = app
        end

        app.set :auth_template_renderer, :erb
        app.set :auth_success_path, '/'
        app.set :auth_failure_path, '/login'

        app.get '/signup' do
          erb :signup
        end

        app.post '/signup' do
          auth_class = defined?(User) ? User : Sinatra::Rider::User
          auth_class.signup(params)

          env['warden'].authenticate!
          redirect '/'
        end

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
