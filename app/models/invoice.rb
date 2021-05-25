class Invoice < ApplicationRecord
  belongs_to :company
  has_many :operations
end
