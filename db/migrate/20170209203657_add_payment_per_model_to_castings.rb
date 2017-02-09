class AddPaymentPerModelToCastings < ActiveRecord::Migration[5.0]
  def change
    add_column :castings, :payment_per_model, :string
  end
end
