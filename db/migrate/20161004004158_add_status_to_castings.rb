class AddStatusToCastings < ActiveRecord::Migration[5.0]
  def change
    add_column :castings, :status, :integer, default: 0
  end
end
