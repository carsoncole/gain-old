require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  setup do
    @transaction = SecurityTransaction.new(
      date: Date.today,
      price: 10,
      quantity: 20,
      security: securities(:three)
      )
  end

  test "for zero cash balance if no transactions" do
    assert_equal 0, accounts(:three).cash_balance(Date.today - 10.days)
  end

  test "for zero security balance if no transactions" do
    assert_equal 0, accounts(:three).security_balance(Date.today - 10.days)
  end

  test "assert cash balance" do
    assert_equal 0, accounts(:four).cash_balance
  end

  test "asset security balance" do
    assert_equal 100, accounts(:four).security_balance(securities(:three))

    @transaction.account = accounts(:four)
    assert @transaction.valid?
    @transaction.save

    assert_equal 120, accounts(:four).security_balance(securities(:three))
  end
end
