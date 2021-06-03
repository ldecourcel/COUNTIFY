class Operation < ApplicationRecord
  belongs_to :account
  belongs_to :invoice, optional: true

  validates :date, :amount, :details, presence: true

  scope :missing, -> { where(validated: false).where(invoice_id: nil) }
  scope :to_validate, -> { where.not(invoice_id: nil).where(validated: false) }
  scope :validated, -> { where(validated: true) }

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :amount, :details, :date ],
    using: {
      tsearch: { prefix: true }
    }
end
