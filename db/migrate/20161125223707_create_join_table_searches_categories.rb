class CreateJoinTableSearchesCategories < ActiveRecord::Migration[5.0]
  def change
  	create_join_table :categories, :searches do |t|
      t.references :category, foreign_key: true
      t.references :search, foreign_key: true
    end
  end
end
