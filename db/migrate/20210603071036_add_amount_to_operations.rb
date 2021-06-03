class AddAmountToOperations < ActiveRecord::Migration[6.0]
  def change
    add_column :operations, :amount, :integer
  end
end
