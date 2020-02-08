# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    trait :invalid do
      name { nil }
    end

    trait :valid do
      name { "Accounting and Finance" }
    end
  end
end
