class AddPlanToProfilePhotographers < ActiveRecord::Migration[5.0]
  def change
    add_reference :profile_photographers, :plan, foreign_key: true
  end
end
