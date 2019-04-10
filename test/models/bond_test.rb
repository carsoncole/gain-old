require 'test_helper'

class BondTest < ActiveSupport::TestCase
  setup do
    @bond_security = Bond.create(
        issuer: issuers(:one)
      )

    @transaction = SecurityTransaction.new(
      date: Date.today,
      price: 90,
      quantity: 10,
      security: @bond_security,
      account: accounts(:three)
      )
  end

  test "correct quantity for a bond" do
    @transaction.save
    assert_equal 10, accounts(:three).security_balance(@bond_security)
  end

  test "correct amount for a bond" do
    @transaction.save
    assert_equal 9000, @transaction.amount
  end
end
