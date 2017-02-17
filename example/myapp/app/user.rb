require 'digest/sha1'

class User < ActiveRecord::Base
  def self.signup(attrs)
    User.where(username: attrs[:username]).first_or_initialize.tap do |u|
      u.name = attrs[:name]
      u.password = attrs[:password]
      u.save!
    end
  end

  def self.authenticate(name, pass)
    user = self.where(username: name).first
    user if user && user.valid_password?(pass)
  end

  def password
    encrypted_password
  end

  def password=(pass)
    self.encrypted_password = Digest::SHA1.hexdigest(pass)
  end

  def valid_password?(pass)
    encrypted_password == Digest::SHA1.hexdigest(pass)
  end
end
