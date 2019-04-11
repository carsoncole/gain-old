# Cash transactions have security_id = nil, and the quantity represents the amount of cash.

class CashTransaction < Transaction
  validates :cash_balance, presence: true

  before_validation :calculate_cash_balance!
  after_save :recalculate_cash_balances!

  private

  def calculate_cash_balance!
    return if avoid_recalc
    self.cash_balance = if account.cash_transactions.empty? 
      quantity
    else
      earlier_transactions = account.cash_transactions.where("date <= ? AND created_at <= ?", date, Time.now)
      if earlier_transactions.any?
        earlier_transactions.last.cash_balance + quantity
      else
        quantity
      end
    end
  end

  def recalculate_cash_balances!
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
