class AddIsPartnerToProfileModels < ActiveRecord::Migration[5.0]
  def change
    add_column :profile_models, :is_partner, :boolean, default: false
  end
end
