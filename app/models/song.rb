class Song < ActiveRecord::Base
  attr_accessible :name, :sort_name, :rating, :url

  validates :name, :presence => true
  validates :rating, :inclusion => { :in => 0..5 }

  belongs_to :album
end
