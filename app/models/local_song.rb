class LocalSong < ActiveRecord::Base
  attr_accessible :location

  belongs_to :song
end
