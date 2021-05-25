class ChangeColumnsFromInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :client, :string
  end
end
