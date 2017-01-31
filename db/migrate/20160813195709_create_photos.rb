class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.attachment :image
      t.string :description
      t.string :func
      t.references :attachable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
