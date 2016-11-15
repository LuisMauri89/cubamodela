class CreateEthnicities < ActiveRecord::Migration[5.0]
  def change
    create_table :ethnicities do |t|
      t.string :name_en
      t.string :name_es

      t.timestamps
    end
  end
end
