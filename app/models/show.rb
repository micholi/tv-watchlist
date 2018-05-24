class Show < ActiveRecord::Base
  has_many :user_shows
  has_many :users, through: :user_shows
  belongs_to :network
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
  include Slugifiable
  extend Slugifiable
end
