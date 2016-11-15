class AddDateOfBirthToProfileModels < ActiveRecord::Migration[5.0]
  def change
    add_column :profile_models, :birth_date, :date
  end
end
