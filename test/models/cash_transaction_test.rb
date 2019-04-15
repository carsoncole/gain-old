require 'test_helper'

class CashTransactionTest < ActiveSupport::TestCase
  setup do
    @transaction = build(:cash_transaction)
  end

  test "balance should equal amount" do
    transaction = create(:cash_transaction,
      quantity: 125
      )
    assert transaction.persisted?
    assert_equal 125, transaction.cash_balance
  end

  test "transaction balance is accurate for subsequent transactions" do
      account = create(:account)
      cash_security = create(:cash, account: account)

      transaction = create(:cash_transaction,
        account: account,
        date: Date.today - 1.day,
        quantity: 125,
        security: cash_security
      )

    20.times do
      create(:cash_transaction,
        account: account,
        date: Date.today,
        quantity: 100,
        security: cash_security
        )
    end

    assert_equal 2125, account.cash_balance(cash_security)
  end

  test "transaction balance is accurate for out-of-order dated transactions" do
    transaction = create(:cash_transaction,
      account: create(:account),
      quantity: 125
    )
    transaction_2 = create(:cash_transaction,
      account: transaction.account,
      date: Date.today - 1.day,
      quantity: 125
      )
    assert_equal 250, transaction.reload.cash_balance
  end

  test "transaction balance is accurate when post-dated transactions" do
    transaction = create(:cash_transaction,
      account: create(:account),
      quantity: 125
    )
    transaction_post_dated = create(:cash_transaction,
      account: transaction.account,
      date: Date.today + 2.days,
      quantity: 125
      )
    assert_equal 125, transaction.cash_balance
  end
end
