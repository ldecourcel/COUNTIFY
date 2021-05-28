class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo

  belongs_to :accountant, optional: true
  belongs_to :company, optional: true

  def is_accountant?
    accountant.present?
  end

  def is_company?
    company.present?
  end

  def initials
    "#{first_name[0].upcase}#{last_name[0].upcase}"
  end
end
