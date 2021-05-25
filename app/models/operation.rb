class Operation < ApplicationRecord
  belongs_to :account
  belongs_to :invoice

  validates :date, :amount, :payee, :validated, presence: true
end
