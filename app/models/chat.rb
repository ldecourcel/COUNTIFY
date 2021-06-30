class Chat < ApplicationRecord
  has_many :messages
  belongs_to :accountant
  belongs_to :company
end
