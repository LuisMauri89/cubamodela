class CreateJoinTableModalityProfilePhotographer < ActiveRecord::Migration[5.0]
  def change
  	create_join_table :profile_photographers, :modalities do |t|
      t.references :profile_photographer, foreign_key: true, index: { name: 'index_modty_prof_photographers_on_profile_photographer_id' }
      t.references :modality, foreign_key: true
    end
  end
end
