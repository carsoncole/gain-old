class Transaction < ApplicationRecord
  belongs_to :account

  validates :date, :account_id, presence: true

  before_save :calculate_amount!, if: Proc.new{|t| t.price.present? && t.quantity.present? }

  before_save :calculate_balance!

  default_scope { order(date: :asc, created_at: :desc) }

  private

  def calculate_amount!
    self.amount = price * quantity
  end

  def calculate_balance!
    #FIXME Needs to account for out-of-date-order trans entry
    self.balance = account.transactions.last.balance + amount
  end

end
