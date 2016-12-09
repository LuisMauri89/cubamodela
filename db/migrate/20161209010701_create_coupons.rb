class CreateCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :coupons do |t|
      t.decimal :amount, precision: 5, scale: 2
      t.string :code
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
