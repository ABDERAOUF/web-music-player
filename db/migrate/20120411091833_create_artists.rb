class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.string :sort_name

      t.timestamps
    end
  end
end
