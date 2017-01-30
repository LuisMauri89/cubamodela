class AddNationalityToProfileModel < ActiveRecord::Migration[5.0]
  def change
    add_reference :profile_models, :nationality, foreign_key: true, index: true
  end
end
