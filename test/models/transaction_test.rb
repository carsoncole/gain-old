require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  setup do
    @transaction = SecurityTransaction.new(date: Date.today, account_id: 1, security_id: 1, quantity: 1, price: 1, amount: 1, balance: 1)
  end
  
  # test "amount is cash and can only have 2 digits" do
  #   @transaction.amount  = 0.12345
  #   @transaction.save
  #   assert_equal 0.12, @transaction.amount
  # end

  # test "balance is cash and can only have 2 digits" do
  #   @transaction.balance = 0.123
  #   @transaction.save
  #   assert_equal 0.12, @transaction.balance
  # end

  test "amount equals quantity x2 price" do
    @transaction.price, @transaction.quantity = 10,12
    @transaction.save
    assert_equal 120, @transaction.amount
  end

  test "default order of transactions date, created_at" do
    @transaction.date = '2017-01-01'
    @transaction.save
    assert_equal transactions(:one), Transaction.last
  end
end
