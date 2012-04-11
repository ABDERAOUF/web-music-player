class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.string :sort_name
      t.integer :rating
      t.string :url

      t.timestamps
    end
    add_index :songs, :album_id
  end
end
