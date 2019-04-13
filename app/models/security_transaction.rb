class SecurityTransaction < Transaction
  belongs_to :security

  validates :security_balance, :quantity, :transaction_type, presence: true

  before_validation :calculate_security_balance!
  after_save :recalculate_security_balances!

  before_validation :calculate_amount!, if: Proc.new{|t| t.price.present? && t.quantity.present? }

  private

  def calculate_amount!
    qty = transaction_type == 'Buy' ? quantity : -quantity
    self.amount = price / security.price_unit * security.par_value * qty
  end

  def calculate_security_balance!
    return if avoid_recalc
    qty = transaction_type == 'Buy' ? quantity : -quantity
    self.security_balance = if account.security_transactions.where(security_id: security_id).empty? 
      qty
    else
      account.security_transactions.where("date <= ? AND created_at <= ? AND security_id = ?", date, Time.now, security_id).last.security_balance + qty
    end
  end

  def recalculate_security_balances!
    return if avoid_recalc
    transactions_to_process = account.security_transactions.where("date > ? OR (date = ? AND created_at > ? AND security_id = ?)", date, date, created_at, security_id)
    return if transactions_to_process.empty?
    last_balance = self.security_balance
    transactions_to_process.each do |t|
      qty = transaction_type == 'Buy' ? t.quantity : -t.quantity
      t.security_balance = last_balance + qty
      last_balance = t.security_balance
      t.avoid_recalc = true
      t.save
    end
  end

end