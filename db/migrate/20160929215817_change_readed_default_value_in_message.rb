class ChangeReadedDefaultValueInMessage < ActiveRecord::Migration[5.0]
  def change
  	change_column_default :messages, :readed, false
  end
end
