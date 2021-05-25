class Invoice < ApplicationRecord
  belongs_to :company
  has_many :operations

  validates :date, :net_amount, :issuer, :vta, :payment_method, :tax_amount, :label, :client, presence: true

  # has_attached :file
end
