# frozen_string_literal: true

FactoryBot.define do
  factory :alice, class: 'User' do
    email { 'alice@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Time.current }
  end
end
