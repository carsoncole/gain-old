class Account < ApplicationRecord
  has_many :accounts_users
  has_many :securities, dependent: :destroy
  has_many :users, through: :accounts_users
  has_many :transactions, dependent: :destroy
  has_many :security_transactions
  has_many :cash_transactions
  has_many :stocks
  has_many :bonds
  has_many :cashes

  validates :title, presence: true

  def cash_balance(security, date=Date.today)
    last = cash_transactions.where("security_id = ? AND date <= ?", security.id, date).last
    if last
      last.cash_balance
    else
      0
    end
  end

  def security_balance(security, date=Date.today)
    last = security_transactions.where(security_id: security.id).where("date <= ?", date).last
    if last
      last.security_balance
    else
      0
    end
  end

  #OPTIMIZE This is not efficient. Reconsider approach
  def holdings(date=Date.today)
    security_ids = transactions.distinct.pluck(:security_id)
    results = []
    security_ids.each do |s|
      security = Security.find(s)
      if security.class == Cash
        balance = cash_balance(security)
      else
        balance = security_balance(Security.find(s))
      end
      results << [ s, balance ] if balance.nonzero?
    end
    results
  end

  def cash_security(currency)
    securities.find_or_create_by!(type: 'Cash', currency: currency)
  end
end
