class CreateCastingReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :casting_reviews do |t|
      t.references :casting, foreign_key: true
      t.references :profile_contractor, foreign_key: true
      t.boolean :show_again

      t.timestamps
    end
  end
end
