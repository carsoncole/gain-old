require 'test_helper'

class CashTransactionTest < ActiveSupport::TestCase
  setup do
    @transaction = CashTransaction.new(date: Date.today, account: accounts(:two))
  end

  test "balance should equal amount" do
    @transaction.amount = 125
    @transaction.save
    assert_equal 175, @transaction.cash_balance
  end

  test "balance is accurate for subsequent transactions" do
    assert_equal 50, accounts(:two).cash_balance

    @transaction_2 = accounts(:two).cash_transactions.create(
      date: Date.today - 1.day,
      amount: 125
      )
    assert_equal 175, accounts(:two).cash_balance
  end

  test "balance is accurate for out-of-order dated transactions" do
    @transaction_2 = accounts(:two).cash_transactions.create(
      date: Date.today - 10.days,
      amount: 200
      )
    assert_equal 250, accounts(:two).cash_balance
  end

  test "balance is correct for an earlier date" do
    @transaction_2 = accounts(:two).cash_transactions.create(
      date: Date.today - 1.day,
      amount: 55
      )
    assert_equal 50, accounts(:two).cash_balance(Date.today - 7.days)
    assert_equal 105, accounts(:two).cash_balance(Date.today)
  end
end