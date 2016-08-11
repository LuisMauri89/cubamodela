class CreateExpertises < ActiveRecord::Migration[5.0]
  def change
    create_table :expertises do |t|
      t.string :name

      t.timestamps
    end
  end
end
