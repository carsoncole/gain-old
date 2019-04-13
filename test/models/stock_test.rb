require 'test_helper'

class StockTest < ActiveSupport::TestCase
  setup do
    @stock_security = create(:stock)
    @account = create(:account)
    @transaction = build(:security_transaction,
      price: 90,
      quantity: 10,
      security: @stock_security,
      account: @account
      )
  end

  test "correct quantity for a stock" do
    @transaction.save
    assert_equal 10, @account.security_balance(@stock_security)
  end

  test "correct amount for a stock" do
    @transaction.save
    assert_equal 900, @transaction.amount
  end
end
