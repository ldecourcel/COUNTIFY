class ChangeInvoiceIdNullToOperations < ActiveRecord::Migration[6.0]
  def change
    change_column_null :operations, :invoice_id, true
  end
end
