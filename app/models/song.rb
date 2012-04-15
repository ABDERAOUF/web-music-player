class Song < ActiveRecord::Base
  attr_accessible :name, :sort_name, :rating, :play_count, :track_number, :src_url
  after_initialize :defaults

  validates :name, :presence => true
  validates :rating, :inclusion => { :in => 0..5 }

  belongs_to :album

  def defaults
    self.rating     ||= 0
    self.play_count ||= 0
  end
end
