# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  describe '正常系' do
    it '登録成功' do
      book = build(:cherry)
      book.valid?
      expect(book).to be_valid
    end
  end

  describe 'ISBN' do
    context '空の場合' do
      it '登録失敗' do
        book = build(:cherry, 'isbn_13' => '')
        book.valid?
        expect(book).to be_invalid
      end
    end

    context '12桁の場合' do
      it '登録失敗' do
        book = build(:cherry, 'isbn_13' => '978123456789')
        book.valid?
        expect(book).to be_invalid
      end
    end

    context '14桁の場合' do
      it '登録失敗' do
        book = build(:cherry, 'isbn_13' => '97812345678901')
        book.valid?
        expect(book).to be_invalid
      end
    end
  end

  describe 'price' do
    context '空の場合' do
      it '登録失敗' do
        book = build(:cherry, price: '')
        book.valid?
        expect(book).to be_invalid
      end
    end

    context '文字列の場合' do
      it '登録失敗' do
        book = build(:cherry, price: '百円')
        book.valid?
        expect(book).to be_invalid
      end
    end
  end

  describe 'title' do
    context '空の場合' do
      it '登録失敗' do
        book = build(:cherry, title: '')
        book.valid?
        expect(book).to be_invalid
      end
    end
  end

  describe 'author' do
    context '空の場合' do
      it '登録失敗' do
        book = build(:cherry, author: '')
        book.valid?
        expect(book).to be_invalid
      end
    end
  end

  describe 'image' do
    context '空の場合' do
      it '登録失敗' do
        book = build(:cherry, image: '')
        book.valid?
        expect(book).to be_invalid
      end
    end
  end

  describe 'url' do
    context '空の場合' do
      it '登録失敗' do
        book = build(:cherry, url: '')
        book.valid?
        expect(book).to be_invalid
      end
    end
  end

  describe 'sales_date' do
    context '空の場合' do
      it '登録失敗' do
        book = build(:cherry, sales_date: '')
        book.valid?
        expect(book).to be_invalid
      end
    end
  end
end
