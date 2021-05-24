class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :siren
      t.string :siret
      t.string :fiscal_regim
      t.string :address
      t.string :phone_number
      t.references :accountant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
