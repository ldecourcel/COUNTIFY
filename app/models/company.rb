class Company < ApplicationRecord
  belongs_to :accountant
  has_many :accounts

  validates :name, :siren, :siret, :fiscal_regim, :address, :phone_number, presence: true

end
