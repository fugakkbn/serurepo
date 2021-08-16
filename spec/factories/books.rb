# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    isbn_13 { 'MyString' }
    price { 1 }
  end
end
