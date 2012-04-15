class CreateLocalSongs < ActiveRecord::Migration
  def change
    create_table :local_songs do |t|
      t.string :location
      t.references :song

      t.timestamps
    end
    add_index :local_songs, :song_id
  end
end
