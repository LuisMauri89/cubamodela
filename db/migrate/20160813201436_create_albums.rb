class CreateAlbums < ActiveRecord::Migration[5.0]
  def change
    create_table :albums do |t|
      t.string :name
      t.references :profileable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
