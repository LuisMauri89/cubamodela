class AddRefToStudy < ActiveRecord::Migration[5.0]
  def change
    add_reference :studies, :ownerable, polymorphic: true, index: true
  end
end
