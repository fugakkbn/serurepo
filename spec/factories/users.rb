# frozen_string_literal: true

FactoryBot.define do
  factory :alice, class: 'User' do
    email { 'alice@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Time.current }
    uid { SecureRandom.uuid }
  end

  factory :google_oauth, class: 'User' do
    email { 'google@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Time.current }
    uid { SecureRandom.uuid }
    provider { 'google_oauth2' }
  end

  factory :rating_even, class: 'User' do
    email { 'even@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Time.current }
    discount_rating { :even }
    uid { SecureRandom.uuid }
  end

  factory :rating_over10, class: 'User' do
    email { 'over10@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Time.current }
    discount_rating { :over10 }
    uid { SecureRandom.uuid }
  end

  factory :rating_over20, class: 'User' do
    email { 'over20@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Time.current }
    discount_rating { :over20 }
    uid { SecureRandom.uuid }
  end

  factory :rating_over30, class: 'User' do
    email { 'over30@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Time.current }
    discount_rating { :over30 }
    uid { SecureRandom.uuid }
  end

  factory :rating_over50, class: 'User' do
    email { 'over50@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Time.current }
    discount_rating { :over50 }
    uid { SecureRandom.uuid }
  end
end
