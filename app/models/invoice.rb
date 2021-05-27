class Invoice < ApplicationRecord
  belongs_to :company
  has_many :operations
  has_one_attached :photo

  validates :photo, :date, :net_amount, :issuer, :vta, :payment_method, :tax_amount, :client, presence: true

  # has_attached :file
end
