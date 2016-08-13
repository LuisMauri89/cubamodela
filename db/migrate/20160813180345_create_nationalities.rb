class CreateNationalities < ActiveRecord::Migration[5.0]
  def change
    create_table :nationalities do |t|
      t.string :name_es
      t.string :name_en

      t.timestamps
    end
  end
end
