class CreateProfileModels < ActiveRecord::Migration[5.0]
  def change
    create_table :profile_models do |t|
      t.string :first_name
      t.string :last_name
      t.string :mobile_phone
      t.string :land_phone
      t.string :address
      t.string :email
      t.decimal :chest
      t.decimal :waist
      t.decimal :hips

      t.timestamps
    end
  end
end
