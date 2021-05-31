class Accountant < ApplicationRecord
  validates :name, presence: true
  has_many :companies
end
