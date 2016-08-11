class AddRefColorToProfileModels < ActiveRecord::Migration[5.0]
  def change
    add_reference :profile_models, :ayes_color, foreign_key: true, index: true
  end
end
