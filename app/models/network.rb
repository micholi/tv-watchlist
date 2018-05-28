class Network < ActiveRecord::Base
  has_many :shows
  include Slugifiable
  extend Slugifiable
end
