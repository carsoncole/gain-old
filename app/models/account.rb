class Account < ApplicationRecord
  has_many :accounts_users
  has_many :users, through: :accounts_users
  has_many :transactions
  has_many :security_transactions
  has_many :cash_transactions

  validates :title, presence: true

  def cash_balance(date=Date.today)
    last = cash_transactions.where("date <= ?", date).last
    if last
      last.cash_balance
    else
      0
    end
  end

  def security_balance(security, date=Date.today)
    last = security_transactions.where(security: security).where("date <= ?", date).last
    if last
      last.security_balance
    else
      0
    end
  end
end
