class Album < ActiveRecord::Base
  attr_accessible :name, :sort_name, :rating, :release_date, :cover_url

  validates :name, :presence => true
  validates :rating, :inclusion => { :in => 0..5 }

  belongs_to :artist
  has_many :songs
end
