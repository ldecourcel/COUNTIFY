class AddAccountantToChats < ActiveRecord::Migration[6.0]
  def change
    add_reference :chats, :accountant, null: false, foreign_key: true
    add_reference :chats, :company, null: false, foreign_key: true
  end
end
