# frozen_string_literal: true

FactoryBot.define do
  factory :list, class: 'List' do
    user factory: :alice
    name { '通知リスト' }
  end
end
