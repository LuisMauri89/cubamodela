class ChangeProfileTypeToExpertises < ActiveRecord::Migration[5.0]
  def change
  	remove_column :expertises, :profile_type, :string
  	add_column :expertises, :profile_type, :integer
  end
end
