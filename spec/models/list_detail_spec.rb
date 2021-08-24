# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListDetail, type: :model do
  context '全ての想定の値の場合' do
    it '登録成功' do
      detail = create(:list_detail_one)
      expect(detail).to be_valid
    end
  end

  describe 'list_id' do
    context '空の場合' do
      it '登録失敗' do
        detail = build(:list_detail_one, list_id: '')
        detail.valid?
        expect(detail.errors[:list_id]).to include('を入力してください')
      end
    end

    context '文字列の場合' do
      it '登録失敗' do
        detail = build(:list_detail_one, list_id: 'テスト')
        detail.valid?
        expect(detail.errors[:list_id]).to include('は数値で入力してください')
      end
    end
  end

  describe 'book_id' do
    context '空の場合' do
      it '登録失敗' do
        detail = build(:list_detail_one, book_id: '')
        detail.valid?
        expect(detail.errors[:book_id]).to include('を入力してください')
      end
    end

    context '文字列の場合' do
      it '登録失敗' do
        detail = build(:list_detail_one, book_id: 'テスト')
        detail.valid?
        expect(detail.errors[:book_id]).to include('は数値で入力してください')
      end
    end
  end
end
