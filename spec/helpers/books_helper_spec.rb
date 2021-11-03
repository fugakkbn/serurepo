# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BooksHelper, type: :helper do
  describe '#format_price' do
    context '数値の場合' do
      it '4桁の場合、カンマ区切りに円が付くこと' do
        price = 1500
        expect(format_price(price)).to eq '1,500円'
      end

      it '3桁の場合、カンマなしで円が付くこと' do
        price = 900
        expect(format_price(price)).to eq '900円'
      end
    end

    context '文字列の場合' do
      it '4桁の場合、カンマ区切りに円が付くこと' do
        price = '1500'
        expect(format_price(price)).to eq '1,500円'
      end

      it '3桁の場合、カンマなしで円が付くこと' do
        price = '900'
        expect(format_price(price)).to eq '900円'
      end

      it '半角数字以外の場合、「情報なし」と返ること' do
        price = 'あいう'
        expect(format_price(price)).to eq '情報なし'
      end
    end
  end
end
