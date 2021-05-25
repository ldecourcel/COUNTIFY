class Company < ApplicationRecord
  belongs_to :accountant
  has_many :accounts
end
