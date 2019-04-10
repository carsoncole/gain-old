require 'test_helper'

class StockTest < ActiveSupport::TestCase
  setup do
    @stock_security = Stock.create(
        issuer: issuers(:one)
      )

    @transaction = SecurityTransaction.new(
      date: Date.today,
      price: 90,
      quantity: 10,
      security: @stock_security,
      account: accounts(:three)
      )
  end

  test "correct quantity for a stock" do
    @transaction.save
    assert_equal 10, accounts(:three).security_balance(@stock_security)
  end

  test "correct amount for a stock" do
    @transaction.save
    assert_equal 900, @transaction.amount
  end
end
