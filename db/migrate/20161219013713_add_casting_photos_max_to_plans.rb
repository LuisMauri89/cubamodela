class AddCastingPhotosMaxToPlans < ActiveRecord::Migration[5.0]
  def change
    add_column :plans, :casting_photos_references_max, :integer, default: 0
  end
end
