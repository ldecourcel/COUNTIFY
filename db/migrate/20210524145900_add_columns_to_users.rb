class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :accountant, foreign_key: true
    add_reference :users, :company, foreign_key: true
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end
