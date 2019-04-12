require 'test_helper'

class SecurityTest < ActiveSupport::TestCase
  test "security can be created without issuer" do
    assert Security.create
  end

  test "only one non-issuer (cash) security can exist per currency" do
    usd_security = Security.new(currency: 'usd', is_cash: true)
    assert usd_security.save

    jpy_security = Security.new(currency: 'jpy', is_cash: true)
    assert jpy_security.save

    second_usd_security = Security.create(currency: 'usd', is_cash: true)

    assert_equal second_usd_security.errors["issuer"][0], "has already been taken"
  end

  test "more than one issuer security can exist per currency" do
    usd_security = Stock.new(issuer: issuers(:one), currency: 'usd')
    assert usd_security.save

    # second_usd_security = Stock.new(issuer: issuers(:two), currency: 'usd')
    # assert second_usd_security.save
  end
end
