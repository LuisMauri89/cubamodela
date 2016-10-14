class AddReviewedToProfileModels < ActiveRecord::Migration[5.0]
  def change
    add_column :profile_models, :reviewed, :boolean, default: false
  end
end
