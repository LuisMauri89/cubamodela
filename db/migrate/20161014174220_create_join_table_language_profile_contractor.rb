class CreateJoinTableLanguageProfileContractor < ActiveRecord::Migration[5.0]
  def change
  	create_join_table :languages, :profile_contractors do |t|
      t.references :language, foreign_key: true
      t.references :profile_contractor, foreign_key: true
    end
  end
end
