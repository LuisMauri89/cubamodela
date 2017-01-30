class AddIsPartnerToProfileContractors < ActiveRecord::Migration[5.0]
  def change
    add_column :profile_contractors, :is_partner, :boolean, default: false
  end
end
