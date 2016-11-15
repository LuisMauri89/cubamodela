class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name_en
      t.string :name_es

      t.timestamps
    end
  end
end
