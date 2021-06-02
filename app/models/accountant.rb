class Accountant < ApplicationRecord
  validates :name, presence: true
  has_many :companies
  has_many :chats
end
