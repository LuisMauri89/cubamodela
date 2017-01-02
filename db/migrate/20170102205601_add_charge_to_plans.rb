class AddChargeToPlans < ActiveRecord::Migration[5.0]
  def change
    add_column :plans, :charge_per_month, :decimal, precision: 5, scale: 2, default: 0
  end
end
