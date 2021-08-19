# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BooksHelper, type: :helper do
  describe '#registered?' do
    it '登録済みの書籍の場合はtrueが返る' do
      list_detail = create(:list_detail_one)
      isbn = list_detail.book.isbn_13
      user = list_detail.list.user
      expect(helper).to be_registered(isbn, user)
    end

    it '登録済みでない書籍の場合はfalseが返る' do
      isbn = create(:perfect_rails).isbn_13
      user = create(:list).user
      expect(helper).not_to be_registered(isbn, user)
    end

    it 'リスト未作成のユーザーの場合はfalseが返る' do
      isbn = create(:perfect_rails).isbn_13
      user = create(:alice)
      expect(helper).not_to be_registered(isbn, user)
    end

    it '未登録の書籍の場合はfalseが返る' do
      isbn = build(:perfect_rails).isbn_13
      user = create(:alice)
      expect(helper).not_to be_registered(isbn, user)
    end
  end
end
