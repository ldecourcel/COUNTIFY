class Operation < ApplicationRecord
  belongs_to :account
  belongs_to :invoice, optional: true

  validates :date, :amount, :details, presence: true

  monetize :amount_cents, with_currency: :eur


  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :amount, :details, :date ],
    using: {
      tsearch: { prefix: true }
    }
end
