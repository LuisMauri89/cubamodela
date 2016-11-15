class CreateJoinTableCategoriesCastings < ActiveRecord::Migration[5.0]
  def change
  	create_join_table :castings, :categories do |t|
      t.references :profile_model, foreign_key: true
      t.references :casting, foreign_key: true
    end
  end
end
