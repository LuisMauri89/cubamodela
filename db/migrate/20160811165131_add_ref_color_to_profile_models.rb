class AddRefColorToProfileModels < ActiveRecord::Migration[5.0]
  def change
    add_column :profile_models, :eyes_color_id, :integer, index: true
  end
end
