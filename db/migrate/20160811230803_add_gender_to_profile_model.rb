class AddGenderToProfileModel < ActiveRecord::Migration[5.0]
  def change
    add_column :profile_models, :gender, :string
  end
end
