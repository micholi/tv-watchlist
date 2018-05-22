class Network < ActiveRecord::Base
  has_many :shows
  has_many :genres, through: :shows
end
