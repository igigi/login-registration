require 'digest/md5'

class Token < ActiveRecord::Base
  belongs_to :user

  class << self
    def generate_for user
      salt = "#{user.phone}-#{Time.now}-#{Random.new.rand}"
      self.create( { user: user, content: Digest::MD5.hexdigest(salt) } )
    end
  end
end