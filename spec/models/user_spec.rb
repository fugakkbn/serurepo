# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '正常系' do
    it '登録成功' do
      user = build(:alice)
      expect(user).to be_valid
    end
  end

  describe 'email' do
    context '空の場合' do
      it '登録失敗' do
        user = build(:alice, email: '')
        user.valid?
        expect(user.errors['email']).to include('を入力してください')
      end
    end

    context '@がない場合' do
      it '登録失敗' do
        user = build(:alice, email: 'testexample.com')
        user.valid?
        expect(user.errors['email']).to include('は不正な値です')
      end
    end

    context '登録済みの場合' do
      it '登録失敗' do
        create(:alice)
        user = build(:alice)
        user.valid?
        expect(user.errors['email']).to include('はすでに存在します')
      end
    end
  end

  describe 'discount_rating' do
    context '空の場合' do
      it '登録成功' do
        user = build(:alice, discount_rating: '')
        expect(user).to be_valid
      end

      it '1に設定される' do
        user = create(:alice)
        expect(user.discount_rating.raw).to eq 1
      end
    end
  end

  describe 'provider, uid' do
    context '空の場合' do
      it '登録成功' do
        user = build(:alice, provider: '', uid: '')
        expect(user).to be_valid
      end
    end

    context 'providerとuidの組み合わせが違う場合' do
      it '登録成功' do
        create(:alice, provider: '', uid: '')
        user = build(:google_oauth)
        expect(user).to be_valid
      end
    end

    context 'providerとuidの組み合わせが同じ場合' do
      it '登録失敗' do
        user = create(:google_oauth)
        other_user = build(:alice, provider: user.provider, uid: user.uid)
        other_user.valid?
        expect(other_user.errors['uid']).to include('はすでに存在します')
      end
    end
  end
end
