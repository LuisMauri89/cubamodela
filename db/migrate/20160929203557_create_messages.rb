class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :title
      t.string :body
      t.string :footer
      t.references :ownerable, polymorphic: true, index: true
      t.references :asociateable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
