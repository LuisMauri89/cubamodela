class RemoveEmailFromProfileModel < ActiveRecord::Migration[5.0]
  def change
    remove_column :profile_models, :email, :string
  end
end
