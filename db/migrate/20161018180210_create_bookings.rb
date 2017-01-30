class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.integer :status, default: 0
      t.integer :profile_contractor_id
      t.integer :profile_model_id
      t.text :description
      t.text :location
      t.datetime :casting_date
      t.datetime :shooting_date

      t.timestamps
    end
  end
end
