require 'test_helper'

class SecurityTransactionTest < ActiveSupport::TestCase

  test "security balance is accurate" do
    account = create(:account)
    transaction = create(:security_transaction,
        account: account,
        quantity: 155,
        date: Date.today - 1.day
      )
    assert_equal 155, account.security_balance(transaction.security)

    transaction = create(:security_transaction,
        account: account,
        quantity: 100
      )
    assert_equal 255, account.security_balance(transaction.security)
  end

  test "default order of transactions date, created_at" do
    transaction = create(:security_transaction,
      date: '2015-01-01'
      )
    assert_equal security_transactions(:security_one), SecurityTransaction.last
  end
end
