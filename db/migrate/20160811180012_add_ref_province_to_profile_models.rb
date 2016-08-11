class AddRefProvinceToProfileModels < ActiveRecord::Migration[5.0]
  def change
    add_reference :profile_models, :current_province, foreign_key: true, index: true
  end
end
