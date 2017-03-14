class CreateChatMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_messages do |t|
      t.string :body
      t.references :ownerable, polymorphic: true
      t.references :fromable, polymorphic: true
      t.integer :parent_id, index: true

      t.timestamps
    end
  end
end
