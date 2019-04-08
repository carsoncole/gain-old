class Account < ApplicationRecord
  has_many :accounts_users
  has_many :users, through: :accounts_users

  validates :title, presence: true
end
