class Account < ApplicationRecord
  belongs_to :company
  has_many :operations

  validates :account_name, presence: true

  def name
    account_name
  end
end
