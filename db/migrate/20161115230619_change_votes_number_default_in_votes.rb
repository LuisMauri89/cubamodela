class ChangeVotesNumberDefaultInVotes < ActiveRecord::Migration[5.0]
  def change
  	change_column_default :votes, :votes_number, 0
  end
end
