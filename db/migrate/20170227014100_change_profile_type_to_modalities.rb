class ChangeProfileTypeToModalities < ActiveRecord::Migration[5.0]
  def change
  	remove_column :modalities, :profile_type, :string
  	add_column :modalities, :profile_type, :integer
  end
end
