class CreateProfileContractors < ActiveRecord::Migration[5.0]
  def change
    create_table :profile_contractors do |t|
      t.string :first_name
      t.string :last_name
      t.string :represent
      t.string :mobile_phone
      t.string :land_phone
      t.string :address
      t.integer :nationality_id

      t.timestamps
    end
  end
end
