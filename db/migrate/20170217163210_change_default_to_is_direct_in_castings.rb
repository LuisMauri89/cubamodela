class ChangeDefaultToIsDirectInCastings < ActiveRecord::Migration[5.0]
  def change
  	change_column_default :castings, :is_direct, true
  end
end
