class CreateClothSizes < ActiveRecord::Migration[5.0]
  def change
    create_table :cloth_sizes do |t|
      t.string :gender
      t.string :usa
      t.string :uk
      t.string :eur

      t.timestamps
    end
  end
end
