class AddPaymentToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :payment, :string
  end
end
