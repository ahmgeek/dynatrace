# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    uid { SecureRandom.uuid }
    client_id { Faker::Number.number(digits: 10) }
    sender_iban { Faker::Bank.iban }
    receiver_iban { Faker::Bank.iban }
    amount { Faker::Number.decimal(l_digits: 3, r_digits: 3) }
    currency { Faker::Currency.code }

    initialize_with { new(transaction: attributes.stringify_keys) }
  end
end
