require 'test_helper'

class SecurityTransactionTest < ActiveSupport::TestCase
  setup do
    @transaction = SecurityTransaction.new(date: Date.today, account: accounts(:one), security: securities(:one), quantity: 1, price: 1)
  end

  test "default order of transactions date, created_at" do
    @transaction.date = '2017-01-01'
    @transaction.save
    assert_equal security_transactions(:security_one), SecurityTransaction.last
  end
end
