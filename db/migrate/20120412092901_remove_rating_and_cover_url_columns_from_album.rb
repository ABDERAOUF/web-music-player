class RemoveRatingAndCoverUrlColumnsFromAlbum < ActiveRecord::Migration
  def up
    remove_column :albums, :rating
    remove_column :albums, :cover_url
  end

  def down
    add_column :albums, :cover_url, :string
    add_column :albums, :rating, :integer
  end
end
