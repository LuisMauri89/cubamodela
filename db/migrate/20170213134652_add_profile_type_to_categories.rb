class AddProfileTypeToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :profile_type, :string
  end
end
