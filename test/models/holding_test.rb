require 'test_helper'

class HoldingTest < ActiveSupport::TestCase
  setup do
    @account = accounts(:five)
  end

  test "no holdings with no transactions" do
    assert_empty @account.holdings.where(date: Date.today)
  end

  test "holdings exist after new transactions" do
    @account.security_transactions.create(
      security: securities(:one),
      quantity: 10,
      price: 10,
      date: Date.today
      )

    # there should be one holding
    holdings = @account.holdings.where(date: Date.today)
    assert_equal 1, holdings.count
    assert_equal 10, holdings.first.quantity
    assert_equal securities(:one).id, holdings.first.security_id

    @account.security_transactions.create(
      security: securities(:one),
      quantity: 25,
      price: 10,
      date: Date.today
      )

    # there should be one holding with a new quantity
    holdings = @account.holdings.where(date: Date.today)
    assert_equal 1, holdings.count
    assert_equal 35, holdings.first.quantity

    @account.security_transactions.create(
      security: securities(:two),
      quantity: 15,
      price: 10,
      date: Date.today
      )

    # there should be two holdings
    holdings = @account.holdings.where(date: Date.today)
    assert_equal 2, holdings.count
    assert_equal 35, holdings.where(security_id: securities(:one).id).first.quantity
    assert_equal 15, holdings.where(security_id: securities(:two).id).first.quantity
  end

  test "holdings should reflect correct quantity after updates" do
    transaction = @account.security_transactions.create(
      security: securities(:one),
      quantity: 10,
      price: 10,
      date: Date.today
      )

    transaction.update(quantity: 25)

    holding = @account.holdings.where(date: Date.today, security: securities(:one)).first
    assert_equal 25, holding.quantity
  end

  test "cash in holdings" do
    transaction = @account.cash_transactions.create(
      quantity: 10,
      date: Date.today
      )

    holding = @account.holdings.where(date: Date.today, security_id: nil).first
    assert_equal 10, holding.quantity
  end
end
