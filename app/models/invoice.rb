class Invoice < ApplicationRecord
  belongs_to :company
  has_many :operations, dependent: :destroy
  has_many_attached :photos

  # validates :date, :net_amount, :issuer, :vta, :payment_method, :tax_amount, :client, presence: true

  include PgSearch::Model
  pg_search_scope :global_search_invoice,
    against: [ :date, :total_amount, :issuer, :vta, :client, :invoice_number ],
    using: {
      tsearch: { prefix: true } 
    }
end
