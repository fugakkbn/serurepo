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
end
