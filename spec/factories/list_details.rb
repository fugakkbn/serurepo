# frozen_string_literal: true

FactoryBot.define do
  factory :list_detail_one, class: 'ListDetail' do
    list
    book factory: :cherry
  end
end
