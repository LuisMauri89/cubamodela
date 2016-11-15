class AddEthnicityToProfileModels < ActiveRecord::Migration[5.0]
  def change
    add_reference :profile_models, :ethnicity, foreign_key: true, index: true
  end
end
