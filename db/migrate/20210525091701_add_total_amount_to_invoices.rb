class AddTotalAmountToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :total_amount, :float
    add_column :invoices, :client, :string
  end
end
