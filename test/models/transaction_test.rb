require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  test "security buy reduces cash balance" do
    @transaction = SecurityTransaction.new(
      account: accounts(:three),
      security_id: securities(:one).id,
      date: Date.today,
      quantity: 20,
      price: 10,
      transaction_type: "Buy"
      )

    balance = accounts(:three).cash_balance
    @transaction.save
    assert_equal balance - 200, accounts(:three).cash_balance
  end

  test "security sell increases cash balance" do
    @transaction = SecurityTransaction.new(
      account: accounts(:three),
      security_id: securities(:one).id,
      date: Date.today,
      quantity: 10,
      price: 10,
      transaction_type: "Sell"
      )

    balance = accounts(:three).cash_balance
    @transaction.save
    assert_equal balance + 100, accounts(:three).cash_balance
  end
end
