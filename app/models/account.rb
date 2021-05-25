class Account < ApplicationRecord
  belongs_to :company
  has_many :operations

  validates :iban, :swift, :account_name, presence: true
end
