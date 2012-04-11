class Song < ActiveRecord::Base
  attr_accessible :name, :sort_name, :rating, :url

  belongs_to :album
end
