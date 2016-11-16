class CreateVotants < ActiveRecord::Migration[5.0]
  def change
    create_table :votants do |t|
      t.references :vote, foreign_key: true, index: true
      t.references :votable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
