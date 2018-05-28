class User < ActiveRecord::Base
  has_many :user_shows
  has_many :shows, through: :user_shows
  has_secure_password
  include Slugifiable
  extend Slugifiable
end
