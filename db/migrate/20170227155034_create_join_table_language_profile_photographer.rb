class CreateJoinTableLanguageProfilePhotographer < ActiveRecord::Migration[5.0]
  def change
  	create_join_table :profile_photographers, :languages do |t|
      t.references :profile_photographer, foreign_key: true, index: { name: 'index_lang_prof_photographers_on_profile_photographer_id' }
      t.references :language, foreign_key: true
    end
  end
end
