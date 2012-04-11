class LibraryController < ApplicationController

  def index
    @music = []
    Dir.foreach("//sara/music") { |x| @music.push x }

  end
end
