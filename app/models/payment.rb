class Payment < ApplicationRecord
  belongs_to :account
  belongs_to :invoice
end
