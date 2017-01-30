class AddLevelToProfileModels < ActiveRecord::Migration[5.0]
  def change
    add_column :profile_models, :level, :integer, default: 0
  end
end
