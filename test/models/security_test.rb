require 'test_helper'

class SecurityTest < ActiveSupport::TestCase
  test "security can be created without issuer" do
    assert Security.create
  end

  test "auto creation of cash account" do
    account = create(:account)
    assert account.cash_security('usd')

    assert account.cash_security('usd'), "error"
  end

  test "only one non-issuer (cash) security can exist per currency" do
    account = create(:account)
    usd_cash = Cash.new(currency: 'usd', account: account)
    assert usd_cash.save

    jpy_cash = Cash.new(currency: 'jpy', account: account)
    assert jpy_cash.save

    second_usd_cash = Cash.new(currency: 'usd', account: account)
    second_usd_cash.valid?
    assert_equal second_usd_cash.errors["account"][0], "has already been taken"
  end

  test "more than one issuer security can exist per currency" do
    usd_security = Stock.new(currency: 'usd', account: create(:account))
    assert usd_security.save

    usd_security_2 = Stock.new(currency: 'usd', account: create(:account))
    assert usd_security_2.save, "Failed to create more than 1 same-currency securities"
  end
end
