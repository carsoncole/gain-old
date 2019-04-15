class Security < ApplicationRecord
  belongs_to :issuer, optional: true
  belongs_to :account
  has_many :security_transactions

  def par_value
    1
  end

  def price_unit
    1
  end

  def quantity
    result = if security_transactions.last
      security_transactions.last.security_balance
    else
      0
    end
    result
  end
end
