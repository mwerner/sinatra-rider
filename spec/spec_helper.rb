$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
ENV['RACK_ENV'] = 'test'
require 'rack/test'
require 'simplecov'

SimpleCov.start

require "sinatra/rider"
Sinatra::Rider::User.signup(name: 'Matt', username: 'admin', password: 'hunter1')

class TestServer < Sinatra::Base
  register Sinatra::Rider
end

RSpec.configure do |config|
  include Rack::Test::Methods

  def app()
    TestServer
  end
end
