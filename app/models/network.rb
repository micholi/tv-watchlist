class Network < ActiveRecord::Base
  has_many :shows
  has_many :genres, through: :shows
  include Slugifiable
  extend Slugifiable
end
