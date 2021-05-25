class CreateOperations < ActiveRecord::Migration[6.0]
  def change
    create_table :operations do |t|
      t.date :date
      t.float :amount
      t.string :payee
      t.string :category
      t.references :account, null: false, foreign_key: true
      t.references :invoice, null: false, foreign_key: true
      t.integer :bankin_uu_id
      t.boolean :validated, default: false

      t.timestamps
    end
  end
end
