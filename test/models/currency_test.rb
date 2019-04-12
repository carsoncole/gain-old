require 'test_helper'

class CurrencyTest < ActiveSupport::TestCase
  test "usd currency" do
    assert Currency::CURRENCIES['usd']
  end
end