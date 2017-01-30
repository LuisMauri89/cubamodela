class CreateLevelRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :level_requests do |t|
      t.references :requester, polymorphic: true, index: true
      t.integer :level

      t.timestamps
    end
  end
end
