class ChangeColumnAmountFromOperations < ActiveRecord::Migration[6.0]
  def change
    rename_column :operations, :amount, :amount_cents
  end
end
