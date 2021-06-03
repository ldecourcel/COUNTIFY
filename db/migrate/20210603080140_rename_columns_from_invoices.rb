class RenameColumnsFromInvoices < ActiveRecord::Migration[6.0]
  def change
    rename_column :invoices, :total_amount, :total_amount_cents
    rename_column :invoices, :net_amount, :net_amount_cents
    rename_column :invoices, :tax_amount, :tax_amount_cents
  end
end
