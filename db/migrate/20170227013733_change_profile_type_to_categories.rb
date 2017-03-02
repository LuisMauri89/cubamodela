class ChangeProfileTypeToCategories < ActiveRecord::Migration[5.0]
  def change
  	remove_column :categories, :profile_type, :string
  	add_column :categories, :profile_type, :integer
  end
end
