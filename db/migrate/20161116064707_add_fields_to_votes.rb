class AddFieldsToVotes < ActiveRecord::Migration[5.0]
  def change
    add_reference :votes, :votable, polymorphic: true, index: true
    add_column :votes, :last_vote_date, :date
  end
end
