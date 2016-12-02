class AddFieldDirectToCastings < ActiveRecord::Migration[5.0]
  def change
    add_column :castings, :direct, :boolean
  end
end
