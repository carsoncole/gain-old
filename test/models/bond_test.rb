require 'test_helper'

class BondTest < ActiveSupport::TestCase
  setup do
    @bond_security = create(:bond)
    @account = create(:account)

    @transaction = build(:security_transaction,
      date: Date.today,
      price: 90,
      quantity: 10,
      security: @bond_security,
      account: @account
      )
  end

  test "correct quantity for a bond" do
    @transaction.save
    assert_equal 10, @account.security_balance(@bond_security)
  end

  test "correct amount for a bond" do
    @transaction.save
    assert_equal 9000, @transaction.amount
  end
end
