class SecurityTransaction < Transaction
  validates :security_balance, :quantity, :transaction_type, presence: true

  before_validation :update_amount!
  before_validation :update_security_balance!
  after_save :update_latter_security_balances!
  after_save :create_cash_transaction!


  def update_amount!
    self.amount = price / security.price_unit *
      security.par_value * quantity +
      commission +
      other
  end

  def update_security_balance!
    return if avoid_recalc
    qty = transaction_type == 'Buy' ? quantity : -quantity
    self.security_balance = if account.security_transactions.where(security_id: security_id).empty? 
      qty
    else
      security.quantity + qty
    end
  end

  def update_latter_security_balances!
    return if avoid_recalc
    transactions_to_process = account.security_transactions.where("date > ? OR (date = ? AND created_at > ? AND security_id = ?)", date, date, created_at, security_id)
    return if transactions_to_process.empty?
    last_balance = self.security_balance
    transactions_to_process.each do |t|
      t.security_balance = last_balance + quantity
      last_balance = t.security_balance
      t.avoid_recalc = true
      t.save
    end
  end

  def create_cash_transaction!
    cash_security = account.cash_security(security.currency)
    account.cash_transactions.create(date: date, security: cash_security, quantity: transaction_type == 'Buy' ? -amount : amount)
  end

end