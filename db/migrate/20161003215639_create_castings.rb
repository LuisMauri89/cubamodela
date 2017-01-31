class CreateCastings < ActiveRecord::Migration[5.0]
  def change
    create_table :castings do |t|
      t.string :title
      t.text :description
      t.string :location
      t.datetime :expire_date
      t.references :ownerable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
