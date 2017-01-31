class AddRefProvinceToProfileModels < ActiveRecord::Migration[5.0]
  def change
    add_column :profile_models, :current_province_id, :integer, index: true
  end
end
