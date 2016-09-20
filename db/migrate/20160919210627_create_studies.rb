class CreateStudies < ActiveRecord::Migration[5.0]
  def change
    create_table :studies do |t|
      t.string :title
      t.string :place
      t.string :description

      t.timestamps
    end
  end
end
