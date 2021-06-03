class RemoveAmountFromOperations < ActiveRecord::Migration[6.0]
  def change
    # remove_column :operations, :amount, :string
    remove_column :operations, :amount, :float
  end
end
