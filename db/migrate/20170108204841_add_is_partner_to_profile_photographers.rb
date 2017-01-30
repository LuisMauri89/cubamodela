class AddIsPartnerToProfilePhotographers < ActiveRecord::Migration[5.0]
  def change
    add_column :profile_photographers, :is_partner, :boolean, default: false
  end
end
