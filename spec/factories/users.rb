# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }

    trait :confirmed do
      confirmed_at { Time.current }
    end
  end
end
