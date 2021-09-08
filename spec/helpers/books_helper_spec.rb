# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BooksHelper, type: :helper do
  describe '#registered?' do
    context 'ListDetailに登録済みの書籍の場合' do
      it 'trueが返る' do
        list_detail = create(:list_detail_one)
        isbn = list_detail.book.isbn_13
        user = list_detail.list.user
        expect(helper).to be_registered(isbn, user)
      end
    end

    context 'ListDetailに登録されていない書籍の場合' do
      it 'falseが返る' do
        isbn = create(:perfect_rails).isbn_13
        user = create(:list).user
        expect(helper).not_to be_registered(isbn, user)
      end
    end

    context 'リスト未作成のユーザーの場合' do
      it 'falseが返る' do
        isbn = create(:perfect_rails).isbn_13
        user = create(:alice)
        expect(helper).not_to be_registered(isbn, user)
      end
    end

    context '書籍情報が登録されていない場合' do
      it 'falseが返る' do
        isbn = build(:perfect_rails).isbn_13
        user = create(:alice)
        expect(helper).not_to be_registered(isbn, user)
      end
    end
  end

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
