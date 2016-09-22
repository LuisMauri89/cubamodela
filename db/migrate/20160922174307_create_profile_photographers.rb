class CreateProfilePhotographers < ActiveRecord::Migration[5.0]
  def change
    create_table :profile_photographers do |t|
      t.string :first_name
      t.string :last_name
      t.string :mobile_phone
      t.string :land_phone
      t.string :address
      t.string :gender
      t.references :nationality, foreign_key: true, index: true

      t.timestamps
    end
  end
end
