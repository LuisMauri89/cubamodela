class AddExtraTextFieldToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :extra_text_field, :string
  end
end
