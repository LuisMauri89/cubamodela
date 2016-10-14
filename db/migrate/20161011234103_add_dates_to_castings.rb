class AddDatesToCastings < ActiveRecord::Migration[5.0]
  def change
    add_column :castings, :access_type, :integer, default: 0
    add_column :castings, :casting_date, :datetime
    add_column :castings, :shooting_date, :datetime
  end
end
