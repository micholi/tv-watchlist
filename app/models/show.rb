class Show < ActiveRecord::Base
  belongs_to :network
  belongs_to :user
  include Slugifiable
  extend Slugifiable
end
