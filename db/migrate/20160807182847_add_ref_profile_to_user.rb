class AddRefProfileToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :profileable, polymorphic: true, index: true
  end
end
