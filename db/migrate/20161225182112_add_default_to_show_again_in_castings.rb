class AddDefaultToShowAgainInCastings < ActiveRecord::Migration[5.0]
  def change
  	change_column_default :casting_reviews, :show_again, true
  end
end
