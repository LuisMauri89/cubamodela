class CreateCharges < ActiveRecord::Migration[5.0]
  def change
    create_table :charges do |t|
      t.references :profileable, polymorphic: true, index: true
      t.decimal :wallet_charge_amount, default: 0
      t.decimal :card_charge_amount, default: 0
      t.integer :on_action, default: 0

      t.timestamps
    end
  end
end
