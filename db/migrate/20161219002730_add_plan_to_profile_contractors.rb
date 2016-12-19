class AddPlanToProfileContractors < ActiveRecord::Migration[5.0]
  def change
    add_reference :profile_contractors, :plan, foreign_key: true
  end
end
