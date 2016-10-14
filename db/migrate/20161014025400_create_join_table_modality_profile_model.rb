class CreateJoinTableModalityProfileModel < ActiveRecord::Migration[5.0]
  def change
  	create_join_table :profile_models, :modalities do |t|
      t.references :profile_model, foreign_key: true
      t.references :modality, foreign_key: true
    end
  end
end
