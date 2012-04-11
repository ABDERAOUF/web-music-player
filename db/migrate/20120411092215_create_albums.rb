class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.string :sort_name
      t.integer :rating
      t.date :release_date
      t.string :cover_url
      t.references :artist

      t.timestamps
    end
    add_index :albums, :artist_id
  end
end
