class Artist < ActiveRecord::Base
  attr_accessible :name, :sort_name

  validates :name, :presence => true

  has_many :albums
end
