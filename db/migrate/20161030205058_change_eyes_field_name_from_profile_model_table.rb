class ChangeEyesFieldNameFromProfileModelTable < ActiveRecord::Migration[5.0]
  def change
  	change_table :profile_models do |t|
  	  t.rename :ayes_color_id, :eyes_color_id
	end
  end
end
