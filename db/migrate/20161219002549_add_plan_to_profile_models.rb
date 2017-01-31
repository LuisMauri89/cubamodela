class AddPlanToProfileModels < ActiveRecord::Migration[5.0]
  def change
    add_reference :profile_models, :plan, foreign_key: true
  end
end
