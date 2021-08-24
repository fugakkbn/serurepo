# frozen_string_literal: true

require 'rails_helper'

RSpec.describe List, type: :model do
  describe '正常系' do
    context '全て想定の値の場合' do
      it '登録成功' do
        list = create(:list)
        expect(list).to be_valid
      end
    end

    context 'nameが空の場合' do
      it '登録成功' do
        list = create(:list, name: '')
        expect(list).to be_valid
      end
    end
  end

  describe 'user_id' do
    context '空の場合' do
      it '登録失敗' do
        list = build(:list, user_id: '')
        list.valid?
        expect(list.errors[:user_id]).to include('を入力してください')
      end
    end

    context '文字列の場合' do
      it '登録失敗' do
        list = build(:list, user_id: 'テスト')
        list.valid?
        expect(list.errors[:user_id]).to include('は数値で入力してください')
      end
    end
  end
end
