require 'test_helper'

class HoldingTest < ActiveSupport::TestCase
  setup do
    @account = create(:account)
  end

  test "no holdings with no transactions" do
    assert_empty @account.holdings
  end

  test "holdings exist after new transactions" do
    account = create(:account)
    security_1 = create(:stock, account: account)

    st = create(:security_transaction,
      account: account,
      security: security_1,
      quantity: 10,
      price: 10
      )

    # there should be two holding, 1 cash, 1 security
    assert_equal 2, account.transactions.count, "There should be two transactions"
    assert_equal 2, account.holdings.count
    assert_equal 10, security_1.quantity

    create(:security_transaction,
      account: account,
      security: security_1,
      quantity: 25,
      price: 10,
      )

    # there should be one holding with a new quantity
    assert_equal 2, account.holdings.count
    assert_equal 35, security_1.quantity

    security_2 = create(:stock, account: account)

    create(:security_transaction,
      account: account,
      security: security_2,
      quantity: 15,
      price: 10,
      )

    # there should be two holdings
    holdings = account.holdings
    assert_equal 3, holdings.count
    assert_equal 35, security_1.quantity
    assert_equal 15, security_2.quantity
  end
end
