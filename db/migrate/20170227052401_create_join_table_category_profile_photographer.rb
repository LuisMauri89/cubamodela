class CreateJoinTableCategoryProfilePhotographer < ActiveRecord::Migration[5.0]
  def change
  	create_join_table :profile_photographers, :categories do |t|
      t.references :profile_photographer, foreign_key: true, index: { name: 'index_cat_prof_photographers_on_profile_photographer_id' }
      t.references :category, foreign_key: true
    end
  end
end
