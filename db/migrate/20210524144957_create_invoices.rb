class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.date :date
      t.float :net_amount
      t.string :issuer
      t.float :vta
      t.references :company, null: false, foreign_key: true
      t.string :payment_method
      t.float :tax_amount
      t.string :label

      t.timestamps
    end
  end
end
