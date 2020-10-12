require_relative '../lib/sinatra/rider/user'

Sinatra::Rider::User.signup(name: 'Matt', username: 'admin', password: 'hunter1')
