class AddReadedToMessage < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :readed, :boolean
  end
end
