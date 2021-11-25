# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  describe '正常系' do
    it '登録成功' do
      book = build(:cherry)
      expect(book).to be_valid
    end
  end

  describe 'ISBN' do
    context '空の場合' do
      it '登録失敗' do
        book = build(:cherry, isbn13: '')
        book.valid?
        expect(book.errors[:isbn13]).to include('を入力してください')
      end
    end

    context '12桁の場合' do
      it '登録失敗' do
        book = build(:cherry, isbn13: '978123456789')
        book.valid?
        expect(book.errors[:isbn13]).to include('は13文字で入力してください')
      end
    end

    context '14桁の場合' do
      it '登録失敗' do
        book = build(:cherry, isbn13: '97812345678901')
        book.valid?
        expect(book.errors[:isbn13]).to include('は13文字で入力してください')
      end
    end
  end

  describe 'price' do
    context '空の場合' do
      it '登録失敗' do
        book = build(:cherry, price: '')
        book.valid?
        expect(book.errors[:price]).to include('を入力してください')
      end
    end

    context '文字列の場合' do
      it '登録失敗' do
        book = build(:cherry, price: '百円')
        book.valid?
        expect(book.errors[:price]).to include('は数値で入力してください')
      end
    end
  end

  describe 'title' do
    context '空の場合' do
      it '登録失敗' do
        book = build(:cherry, title: '')
        book.valid?
        expect(book.errors[:title]).to include('を入力してください')
      end
    end
  end

  describe 'author' do
    context '空の場合' do
      it '登録成功' do
        book = build(:cherry, author: '')
        expect(book).to be_valid
      end
    end
  end

  describe 'image' do
    context '空の場合' do
      it '登録失敗' do
        book = build(:cherry, image: '')
        book.valid?
        expect(book.errors[:image]).to include('を入力してください')
      end
    end
  end

  describe 'url' do
    context '空の場合' do
      it '登録失敗' do
        book = build(:cherry, url: '')
        book.valid?
        expect(book.errors[:url]).to include('を入力してください')
      end
    end
  end

  describe 'sales_date' do
    context '空の場合' do
      it '登録成功' do
        book = build(:cherry, sales_date: '')
        expect(book).to be_valid
      end
    end
  end
end
