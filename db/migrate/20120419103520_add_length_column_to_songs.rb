class AddLengthColumnToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :length, :integer

  end
end
