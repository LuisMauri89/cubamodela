class AddProvinceToProfilePhotographers < ActiveRecord::Migration[5.0]
  def change
  	add_column :profile_photographers, :current_province_id, :integer, index: true
  end
end
