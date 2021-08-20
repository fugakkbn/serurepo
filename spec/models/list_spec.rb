# frozen_string_literal: true

require 'rails_helper'

RSpec.describe List, type: :model do
  describe '正常系' do
    context '全て想定の値の場合' do
      it '登録成功' do
        list = create(:list)
        list.valid?
        expect(list).to be_valid
      end
    end

    context 'nameが空の場合' do
      it '登録成功' do
        list = create(:list, name: '')
        list.valid?
        expect(list).to be_valid
      end
    end
  end

  describe '異常系' do
    context 'user_idが空の場合' do
      it '登録失敗' do
        list = build(:list, user_id: '')
        list.valid?
        expect(list).to be_invalid
      end
    end

    context 'user_idが文字列の場合' do
      it '登録失敗' do
        list = build(:list, user_id: 'テスト')
        list.valid?
        expect(list).to be_invalid
      end
    end
  end
end
