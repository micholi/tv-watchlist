class User < ActiveRecord::Base
  has_many :tv_shows
  has_many :networks, through: :network_shows
  has_secure_password

  # more code here

end
