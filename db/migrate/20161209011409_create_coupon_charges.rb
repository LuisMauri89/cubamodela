class CreateCouponCharges < ActiveRecord::Migration[5.0]
  def change
    create_table :coupon_charges do |t|
      t.references :coupon, foreign_key: true
      t.references :wallet, foreign_key: true

      t.timestamps
    end
  end
end
