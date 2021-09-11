# frozen_string_literal: true

FactoryBot.define do
  factory :alice, class: 'User' do
    email { 'alice@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Time.current }
  end
  factory :google_oauth, class: 'User' do
    email { 'google@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Time.current }
    uid { '123456789' }
    provider { 'google_oauth2' }
  end
end
