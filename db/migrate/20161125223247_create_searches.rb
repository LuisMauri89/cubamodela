class CreateSearches < ActiveRecord::Migration[5.0]
  def change
    create_table :searches do |t|
      t.references :province, foreign_key: true
      t.references :nationality, foreign_key: true
      t.integer :age_from
      t.integer :age_to
      t.string :gender
      t.integer :height_from
      t.integer :height_to
      t.boolean :new_face
      t.boolean :professional_model

      t.timestamps
    end
  end
end
