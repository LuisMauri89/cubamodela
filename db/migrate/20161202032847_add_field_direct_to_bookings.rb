class AddFieldDirectToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :direct, :boolean
  end
end
