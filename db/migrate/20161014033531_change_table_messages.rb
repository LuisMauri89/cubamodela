class ChangeTableMessages < ActiveRecord::Migration[5.0]
  def change
  	change_table :messages do |t|
	  t.remove :title
	  t.remove :body
	  t.remove :footer
	  t.integer :template, default: 0
	end
  end
end
