class DropTableVotants < ActiveRecord::Migration[5.0]
  def change
  	drop_table :votants
  end
end
