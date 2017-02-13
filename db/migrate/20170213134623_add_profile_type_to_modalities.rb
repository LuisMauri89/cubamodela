class AddProfileTypeToModalities < ActiveRecord::Migration[5.0]
  def change
    add_column :modalities, :profile_type, :string
  end
end
