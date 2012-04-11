class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.name :string
      t.sort_name :string

      t.timestamps
    end
  end
end
