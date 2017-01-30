class ChangeExpirationDateInTableCastings < ActiveRecord::Migration[5.0]
  def change
  	change_column :castings, :expiration_date, :date
  end
end
