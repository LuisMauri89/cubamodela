class AddWarningToProfilePhotographers < ActiveRecord::Migration[5.0]
  def change
  	add_column :profile_photographers, :warnings_state, :boolean, default: false
    add_column :profile_photographers, :warnings_count, :integer, default: 0
    add_column :profile_photographers, :warnings_last_made, :date
  end
end
