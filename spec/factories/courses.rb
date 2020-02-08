# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    trait :invalid do
      name { nil }
    end

    trait :valid do
      name { "How To Make Lots of Money"}
    end
  end
end
