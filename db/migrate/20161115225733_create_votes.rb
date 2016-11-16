class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.references :ownerable, polymorphic: true, index: true
      t.integer :votes_number

      t.timestamps
    end
  end
end
