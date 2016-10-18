class ChangeTableBookings < ActiveRecord::Migration[5.0]
  def change
  	change_table :bookings do |t|
	  t.remove :ProfileContractor_id
	  t.remove :ProfileModel_id
	  t.references :profile_contractor, foreign_key: true
      t.references :profile_model, foreign_key: true
      t.index [:profile_contractor_id, :profile_model_id]
	end
  end
end
