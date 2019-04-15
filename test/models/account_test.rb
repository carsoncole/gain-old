require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test "create an account from a factory" do
    account = create(:account)
    assert_equal "John Doe", account.title
  end

  test "for zero cash balance if no transactions" do
    account = create(:account)
    cash_security = account.cash_security('usd')
    assert_equal 0, account.cash_balance(cash_security)
  end

  test "for zero security balance if no transactions" do
    account = create(:account)
    assert_equal 0, account.security_balance(create(:security, account: account))
  end
end
