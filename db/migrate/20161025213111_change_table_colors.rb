class ChangeTableColors < ActiveRecord::Migration[5.0]
  def change
  	change_table :colors do |t|
  	  t.rename :name, :name_en
  	  t.string :name_es
	end
  end
end
