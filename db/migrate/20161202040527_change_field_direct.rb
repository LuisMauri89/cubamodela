class ChangeFieldDirect < ActiveRecord::Migration[5.0]
  def change
  	change_table :bookings do |t|
  	  t.rename :direct, :is_direct
  	end

  	change_table :castings do |t|
  	  t.rename :direct, :is_direct
  	end
  end
end
