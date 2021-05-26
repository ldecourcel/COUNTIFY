class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :accountant, optional: true
  belongs_to :company, optional: true

  def is_accountant?
    accountant.present?
  end

  def is_company?
    company.present?
  end
end
