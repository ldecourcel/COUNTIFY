class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :iban
      t.string :account_name
      t.integer :bankin_uu_id
      t.string :swift
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
