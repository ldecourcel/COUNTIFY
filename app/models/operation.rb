class Operation < ApplicationRecord
  belongs_to :account
  belongs_to :invoice, optional: true

  validates :date, :amount, :details, presence: true
end
