# frozen_string_literal: true

FactoryBot.define do
  factory :vertical do
    trait :invalid do
      name { nil }
    end

    trait :valid do
      name { "Internet Marketing" }
    end
  end
end
