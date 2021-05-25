class Account < ApplicationRecord
  belongs_to :company
  has_many :operations
end
