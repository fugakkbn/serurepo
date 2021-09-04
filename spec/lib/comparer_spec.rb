# frozen_string_literal: true

require 'rails_helper'
require_relative '../../lib/comparer'

RSpec.describe Comparer, type: :module do
  describe '#amazon_comparer' do
    let(:book) { create(:perfect_rails) }
    let(:amazon) { AmazonCrawler.new }

    context '2種類ある場合' do
      context '両方がDBの価格より安い場合' do
        it 'kindleの価格が返ること' do
          amazon.instance_variable_set(:@kindle_price, 2900)
          amazon.instance_variable_set(:@paper_price, 3000)
          result = Comparer::Books.amazon_comparer(amazon, book)
          expect(result[:price]).to eq 2900
        end
      end

      context '片方が安くて片方が高い場合' do
        it '安い方の価格が返ること' do
          amazon.instance_variable_set(:@kindle_price, 2900)
          amazon.instance_variable_set(:@paper_price, 4000)
          result = Comparer::Books.amazon_comparer(amazon, book)
          expect(result[:price]).to eq 2900
        end
      end

      context '片方が安くて片方がDBと同じ場合' do
        it '安い方の価格が返ること' do
          amazon.instance_variable_set(:@kindle_price, 2900)
          amazon.instance_variable_set(:@paper_price, book.price)
          result = Comparer::Books.amazon_comparer(amazon, book)
          expect(result[:price]).to eq 2900
        end
      end

      context '両方がDBの価格と同じ場合' do
        it 'nilが返ること' do
          amazon.instance_variable_set(:@kindle_price, book.price)
          amazon.instance_variable_set(:@paper_price, book.price)
          result = Comparer::Books.amazon_comparer(amazon, book)
          expect(result).to be_nil
        end
      end

      context '両方がDBの価格より高い場合' do
        it 'nilが返ること' do
          amazon.instance_variable_set(:@kindle_price, 4000)
          amazon.instance_variable_set(:@paper_price, 4000)
          result = Comparer::Books.amazon_comparer(amazon, book)
          expect(result).to be_nil
        end
      end
    end

    context '1種類の場合' do
      context 'DBより安い場合' do
        it '価格が返ること' do
          amazon.instance_variable_set(:@paper_price, 2900)
          result = Comparer::Books.amazon_comparer(amazon, book)
          expect(result[:price]).to eq 2900
        end
      end

      context 'DBより高い場合' do
        it 'nilが返ること' do
          amazon.instance_variable_set(:@paper_price, 4000)
          result = Comparer::Books.amazon_comparer(amazon, book)
          expect(result).to be_nil
        end
      end

      context 'DBと同じ場合' do
        it 'nilが返ること' do
          amazon.instance_variable_set(:@paper_price, book.price)
          result = Comparer::Books.amazon_comparer(amazon, book)
          expect(result).to be_nil
        end
      end
    end

    context 'amazonにない書籍の場合' do
      it 'nilが返ること' do
        result = Comparer::Books.amazon_comparer(amazon, book)
        expect(result).to be_nil
      end
    end
  end

  describe '#dmm_comparer' do
    let(:book) { create(:perfect_rails) }
    let(:dmm) { DmmCrawler.new }

    context 'DBの価格より安い場合' do
      before do
        dmm.instance_variable_set(:@price, 2000)
        dmm.instance_variable_set(:@book_url, book.url)
      end

      it '価格が2000であること' do
        result = Comparer::Books.dmm_comparer(dmm, book)
        expect(result[:price]).to eq 2000
      end

      it 'URLが返ること' do
        result = Comparer::Books.dmm_comparer(dmm, book)
        expect(result[:url]).to eq book.url
      end
    end

    context 'DBの価格より高い場合' do
      it 'nilが返ること' do
        dmm.instance_variable_set(:@price, 4000)
        result = Comparer::Books.dmm_comparer(dmm, book)
        expect(result).to be_nil
      end
    end

    context 'DBの価格と同じ場合' do
      it 'nilが返ること' do
        dmm.instance_variable_set(:@price, 3828)
        result = Comparer::Books.dmm_comparer(dmm, book)
        expect(result).to be_nil
      end
    end

    context 'DMMにない書籍の場合' do
      it 'nilが返ること' do
        result = Comparer::Books.dmm_comparer(dmm, book)
        expect(result).to be_nil
      end
    end
  end

  describe '#rakuten_comparer' do
    let(:book) { create(:perfect_rails) }
    let(:rakuten) { RakutenCrawler.new }

    context '2種類ある場合' do
      context '両方安い場合' do
        it '最も安い価格が返ること' do
          rakuten.instance_variable_set(:@single_price, 5000)
          rakuten.instance_variable_set(:@e_book_price, 2900)
          rakuten.instance_variable_set(:@paper_book_price, 3000)
          result = Comparer::Books.rakuten_comparer(rakuten, book)
          expect(result[:price]).to eq 2900
        end
      end

      context '片方が安くて片方が高い場合' do
        it '安い方の価格が返ること' do
          rakuten.instance_variable_set(:@single_price, 5000)
          rakuten.instance_variable_set(:@e_book_price, 2900)
          rakuten.instance_variable_set(:@paper_book_price, 4000)
          result = Comparer::Books.rakuten_comparer(rakuten, book)
          expect(result[:price]).to eq 2900
        end
      end

      context '片方が安くて片方がDBと同じ場合' do
        it '安い方の価格が返ること' do
          rakuten.instance_variable_set(:@single_price, 5000)
          rakuten.instance_variable_set(:@e_book_price, 2900)
          rakuten.instance_variable_set(:@paper_book_price, book.price)
          result = Comparer::Books.rakuten_comparer(rakuten, book)
          expect(result[:price]).to eq 2900
        end
      end

      context '両方DBと同じ場合' do
        it 'nilが返ること' do
          rakuten.instance_variable_set(:@single_price, 5000)
          rakuten.instance_variable_set(:@e_book_price, book.price)
          rakuten.instance_variable_set(:@paper_book_price, book.price)
          result = Comparer::Books.rakuten_comparer(rakuten, book)
          expect(result).to be_nil
        end
      end

      context '両方DBより高い場合' do
        it 'nilが返ること' do
          rakuten.instance_variable_set(:@single_price, 5000)
          rakuten.instance_variable_set(:@e_book_price, 4000)
          rakuten.instance_variable_set(:@paper_book_price, 4000)
          result = Comparer::Books.rakuten_comparer(rakuten, book)
          expect(result).to be_nil
        end
      end
    end

    context '1種類の場合' do
      context 'DBより安い場合' do
        it '価格が返ること' do
          rakuten.instance_variable_set(:@single_price, 3000)
          result = Comparer::Books.rakuten_comparer(rakuten, book)
          expect(result[:price]).to eq 3000
        end
      end

      context 'DBと同じ場合' do
        it 'nilが返ること' do
          rakuten.instance_variable_set(:@single_price, book.price)
          result = Comparer::Books.rakuten_comparer(rakuten, book)
          expect(result).to be_nil
        end
      end

      context 'DBより高い場合' do
        it 'nilが返ること' do
          rakuten.instance_variable_set(:@single_price, 4000)
          result = Comparer::Books.rakuten_comparer(rakuten, book)
          expect(result).to be_nil
        end
      end
    end

    context '楽天にない書籍の場合' do
      it 'nilが返ること' do
        result = Comparer::Books.rakuten_comparer(rakuten, book)
        expect(result).to be_nil
      end
    end
  end

  describe '#compare_price' do
    let(:e_book_price) { 2500 }
    let(:paper_book_price) { 2500 }

    context '価格が同じ場合' do
      it 'その価格を返すこと' do
        expect(Comparer::Books.compare_price(e_book_price, paper_book_price)).to eq 2500
      end
    end

    context 'paper_bookの方が安い場合' do
      it 'paper_bookの値が返ること' do
        paper_book_price = 2000
        expect(Comparer::Books.compare_price(e_book_price, paper_book_price)).to eq 2000
      end
    end

    context 'e_bookの方が安い場合' do
      it 'e_bookの値が返ること' do
        paper_book_price = 3000
        expect(Comparer::Books.compare_price(e_book_price, paper_book_price)).to eq 2500
      end
    end
  end
end
