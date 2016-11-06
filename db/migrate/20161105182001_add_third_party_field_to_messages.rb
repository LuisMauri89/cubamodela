class AddThirdPartyFieldToMessages < ActiveRecord::Migration[5.0]
  def change
  	add_reference :messages, :thirdable, polymorphic: true, index: true
  end
end
