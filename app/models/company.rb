class Company < ApplicationRecord
  belongs_to :accountant
  has_many :accounts
  has_many :operations, through: :accounts
  has_many :invoices
  has_one :chat

  validates :name, :siren, :siret, :fiscal_regim, :address, :phone_number, presence: true

  def initial
    name[0].upcase
  end

end
