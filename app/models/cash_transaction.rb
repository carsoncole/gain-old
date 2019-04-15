class CashTransaction < Transaction
  validates :cash_balance, :quantity, presence: true

  before_validation :update_cash_balance!
  after_save :update_latter_cash_balances!

  private

  def update_cash_balance!
    return if avoid_recalc
    self.cash_balance = account.cash_balance(security, date) + quantity 
  end

  def update_latter_cash_balances!
    return if avoid_recalc
    transactions_to_process = account.cash_transactions.where("date > ? OR (date = ? AND created_at > ?)", date, date, created_at)
    return if transactions_to_process.empty?
    last_balance = self.cash_balance
    transactions_to_process.each do |t|
      t.cash_balance = last_balance + t.quantity
      last_balance = t.cash_balance
      t.avoid_recalc = true
      t.save
    end
  end


end
