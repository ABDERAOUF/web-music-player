class Album < ActiveRecord::Base
  attr_accessible :name, :sort_name, :year, :cover

  validates :name, :presence => true

  belongs_to :artist
  has_many :songs, :dependent => :destroy

  has_attached_file :cover,
                    :styles => {
                        :large => '300x300>',
                        :thumb => '48x48#' }
end
