class LocalSong < ActiveRecord::Base
  attr_accessible :song_id, :location

  has_one :song
end
