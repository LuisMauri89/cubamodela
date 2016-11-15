class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.references :fromable, polymorphic: true, index: true
      t.references :toable, polymorphic: true, index: true
      t.text :review_en
      t.text :review_es

      t.timestamps
    end
  end
end
