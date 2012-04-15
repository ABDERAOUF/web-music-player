class RenameAlbumReleaseDateToYear < ActiveRecord::Migration
  def change
    rename_column :albums, :release_date, :year
  end
end
