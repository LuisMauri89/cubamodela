class AddReviewedToProfilePhotographers < ActiveRecord::Migration[5.0]
  def change
  	add_column :profile_photographers, :reviewed, :boolean, default: false
  end
end
