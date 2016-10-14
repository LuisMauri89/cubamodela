class CreateIntents < ActiveRecord::Migration[5.0]
  def change
    create_table :intents do |t|
      t.references :aplicable, polymorphic: true, index: true
      t.references :casting, foreign_key: true, index: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
