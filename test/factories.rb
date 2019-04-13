FactoryBot.define do
  factory :user do
    email { "john_doe@example.com" }
  end

  factory :issuer do
    name { "ACME Rubber Company"}
  end

  factory :security do
    issuer
  end

  factory :stock

  factory :bond

  factory :account do
    title { "John Doe"}
  end

  factory :security_transaction do
    date { Date.today }
    quantity { 100 }
    price { 10 }
    transaction_type { 'Buy' }
    account
    association :security, factory: :stock
  end

  factory :cash_transaction do
    date { Date.today }
    account
  end
end
