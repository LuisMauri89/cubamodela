class AddLevelToPlans < ActiveRecord::Migration[5.0]
  def change
    add_column :plans, :level, :integer, default: 0
  end
end
