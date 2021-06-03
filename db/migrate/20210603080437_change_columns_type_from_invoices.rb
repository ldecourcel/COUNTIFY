class ChangeColumnsTypeFromInvoices < ActiveRecord::Migration[6.0]
  def change
    change_column :invoices, :total_amount_cents, :integer
    change_column :invoices, :net_amount_cents, :integer
    change_column :invoices, :tax_amount_cents, :integer
  end
end
