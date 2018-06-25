class Record < ActiveRecord::Base
  validates_presence_of :title, :artist, :year
  validates_uniqueness_of :title
end
