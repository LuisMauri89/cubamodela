class AddProfileTypeToExpertises < ActiveRecord::Migration[5.0]
  def change
    add_column :expertises, :profile_type, :string
  end
end
