class ChangeTableIntents < ActiveRecord::Migration[5.0]
  def change
  	change_table :intents do |t|
	  t.remove :aplicable_type
	  t.remove :aplicable_id
	  t.references :profile_model, foreign_key: true, index: true
	end
  end
end
