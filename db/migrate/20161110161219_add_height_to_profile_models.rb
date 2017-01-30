class AddHeightToProfileModels < ActiveRecord::Migration[5.0]
  def change
    add_column :profile_models, :height, :integer
  end
end
