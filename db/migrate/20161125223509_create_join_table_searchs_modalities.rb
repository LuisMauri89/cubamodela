class CreateJoinTableSearchsModalities < ActiveRecord::Migration[5.0]
  def change
  	create_join_table :modalities, :searches do |t|
      t.references :modality, foreign_key: true
      t.references :search, foreign_key: true
    end
  end
end
