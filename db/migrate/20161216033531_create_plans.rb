class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.integer :target, default: 0
      t.integer :album_professional_max, default: 0
      t.integer :album_polaroid_max, default: 0
      t.integer :priority, default: 0
      t.integer :video_max, default: 0

      t.timestamps
    end
  end
end
