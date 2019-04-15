require 'test_helper'

class SecurityTransactionTest < ActiveSupport::TestCase

  test "security buy reduces cash, increases quantity" do
    transaction = build(:security_transaction)
    cash_security = transaction.account.cash_security('usd')
    cash_balance = transaction.account.cash_balance(cash_security)
    security_balance = transaction.account.security_balance(transaction.security)
    transaction.save

    assert_equal cash_balance - 1000, transaction.account.cash_balance(cash_security)
    assert_equal security_balance + 100, transaction.account.security_balance(transaction.security)
  end

  test "security sell increases cash, decreases quantity" do
    transaction = build(:security_transaction,
      transaction_type: 'Sell',
      account: create(:account)
      )
    account = transaction.account
    cash_security = account.cash_security('usd')
    cash_balance = account.cash_balance(cash_security)
    security_balance = account.security_balance(transaction.security)
    transaction.save

    assert_equal cash_balance + 1000, account.cash_balance(cash_security)
    assert_equal security_balance - 100, account.security_balance(transaction.security)
  end

  test "default order of transactions date, created_at" do
    transaction = create(:security_transaction,
      date: '2015-01-01'
      )
    assert_equal security_transactions(:security_one), SecurityTransaction.last
  end
end
