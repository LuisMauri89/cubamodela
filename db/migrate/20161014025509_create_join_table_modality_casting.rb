class CreateJoinTableModalityCasting < ActiveRecord::Migration[5.0]
  def change
  	create_join_table :castings, :modalities do |t|
      t.references :casting, foreign_key: true
      t.references :modality, foreign_key: true
    end
  end
end
