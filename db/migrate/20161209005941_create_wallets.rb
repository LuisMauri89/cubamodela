class CreateWallets < ActiveRecord::Migration[5.0]
  def change
    create_table :wallets do |t|
      t.decimal :amount, precision: 5, scale: 2
      t.references :ownerable, polymorphic: true, index: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
