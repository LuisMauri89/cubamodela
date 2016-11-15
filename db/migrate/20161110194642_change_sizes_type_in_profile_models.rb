class ChangeSizesTypeInProfileModels < ActiveRecord::Migration[5.0]
  def change
  	change_column :profile_models, :size_shoes, :decimal, precision: 4, scale: 2
  	change_column :profile_models, :size_cloth, :decimal, precision: 4, scale: 2

  	change_column :profile_models, :chest, :decimal, precision: 5, scale: 2
  	change_column :profile_models, :waist, :decimal, precision: 5, scale: 2
  	change_column :profile_models, :hips, :decimal, precision: 5, scale: 2
  end
end
