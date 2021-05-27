class Company < ApplicationRecord
  belongs_to :accountant
  has_many :accounts
  has_many :invoices

  validates :name, :siren, :siret, :fiscal_regim, :address, :phone_number, presence: true
end
