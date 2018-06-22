class Record < ActiveRecord::Base
  validates_presence_of :title, :artist, :year
end
