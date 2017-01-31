class CreateJoinTableExpertiseProfileModel < ActiveRecord::Migration[5.0]
  def change
    create_join_table :profile_models, :expertises do |t|
      t.references :profile_model, foreign_key: true
      t.references :expertise, foreign_key: true
    end
  end
end
