class ChangeTableCastings < ActiveRecord::Migration[5.0]
  def change
  	change_table :castings do |t|
	  t.rename :expire_date, :expiration_date
	end
  end
end
