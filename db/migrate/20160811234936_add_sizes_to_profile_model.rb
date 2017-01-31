class AddSizesToProfileModel < ActiveRecord::Migration[5.0]
  def change
    add_column :profile_models, :size_shoes, :integer
    add_column :profile_models, :size_cloth, :integer
  end
end
