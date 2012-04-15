class RenameSongsUrlColumn < ActiveRecord::Migration
  def change
    rename_column :songs, :url, :src_url
  end
end
