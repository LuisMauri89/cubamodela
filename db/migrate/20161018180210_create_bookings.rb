class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.integer :status, default: 0
      t.references :ProfileContractor, foreign_key: true
      t.references :ProfileModel, foreign_key: true
      t.text :description
      t.text :location
      t.datetime :casting_date
      t.datetime :shooting_date

      t.timestamps
    end
  end
end
