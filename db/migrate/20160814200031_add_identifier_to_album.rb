class AddIdentifierToAlbum < ActiveRecord::Migration[5.0]
  def change
    add_column :albums, :identifier, :integer
    add_index :albums, :identifier
  end
end
