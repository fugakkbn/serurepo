# frozen_string_literal: true

require 'rails_helper'
require_relative '../../lib/mail_sender'

RSpec.describe MailSender, type: :module do
  let(:price_data) do
    {
      amazon: {
        price: 1000,
        url: 'https://amazon.com'
      },
      dmm: {
        price: 2000,
        url: 'https://books.dmm.com'
      },
      rakuten: {
        price: 3000,
        url: 'https://books.rakuten.com'
      }
    }
  end

  # TODO: #sale_reportのテストを書く

  describe '#all_data_nil?' do
    context '全ての属性が存在する場合' do
      it 'falseが返ること' do
        expect(described_class).not_to be_all_data_nil(price_data)
      end
    end

    context 'いずれか1つの属性が存在しない場合' do
      it 'falseが返ること' do
        price_data[:amazon] = nil
        expect(described_class).not_to be_all_data_nil(price_data)
      end
    end

    context 'いずれか2つの属性が存在しない場合' do
      it 'falseが返ること' do
        price_data[:amazon] = nil
        price_data[:dmm] = nil
        expect(described_class).not_to be_all_data_nil(price_data)
      end
    end

    context '全ての属性が存在しない場合' do
      it 'trueが返ること' do
        price_data[:amazon] = nil
        price_data[:dmm] = nil
        price_data[:rakuten] = nil
        expect(described_class).to be_all_data_nil(price_data)
      end
    end
  end

  describe '#get_rating' do
    context 'evenのユーザーの場合' do
      it '1が返ること' do
        user = create(:rating_even)
        expect(described_class.get_rating(user)).to eq 1
      end
    end

    context 'over10のユーザーの場合' do
      it '0.9が返ること' do
        user = create(:rating_over10)
        expect(described_class.get_rating(user)).to eq 0.9
      end
    end

    context 'over20のユーザーの場合' do
      it '0.8が返ること' do
        user = create(:rating_over20)
        expect(described_class.get_rating(user)).to eq 0.8
      end
    end

    context 'over30のユーザーの場合' do
      it '0.7が返ること' do
        user = create(:rating_over30)
        expect(described_class.get_rating(user)).to eq 0.7
      end
    end

    context 'over50のユーザーの場合' do
      it '0.5が返ること' do
        user = create(:rating_over50)
        expect(described_class.get_rating(user)).to eq 0.5
      end
    end

    context '規定外の数値の場合' do
      it '1が返ること' do
        user = create(:rating_even)
        user.discount_rating = ''
        expect(described_class.get_rating(user)).to eq 1
      end
    end
  end

  describe '#higher_than_discounted_price?' do
    let(:discount_price) { 500 }

    context 'データが存在し、割引設定に準じた金額より高い場合' do
      it 'trueを返すこと' do
        expect(described_class).to be_higher_than_discounted_price(price_data[:amazon], discount_price)
      end
    end

    context 'データが存在し、割引設定に準じた金額より安い場合' do
      it 'falseを返すこと' do
        price_data[:amazon][:price] = 400
        expect(described_class).not_to be_higher_than_discounted_price(price_data[:amazon], discount_price)
      end
    end

    context 'データが存在せず、割引設定に準じた金額より高い場合' do
      it 'falseを返すこと' do
        price_data[:amazon] = nil
        expect(described_class).not_to be_higher_than_discounted_price(price_data[:amazon], discount_price)
      end
    end
  end
end
