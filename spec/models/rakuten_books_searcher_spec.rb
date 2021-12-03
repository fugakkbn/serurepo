# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RakutenBooksSearcher, type: :model do
  describe '#initialize' do
    context '13桁のISBNが指定された場合' do
      it 'クエリストリングにisbnがあること' do
        searcher = described_class.new('9784774193977', 1, 20)
        expect(searcher.instance_variable_get(:@url)).to include 'isbn'
      end
    end

    context 'isbnではない場合' do
      it 'クエリストリングにtitleがあること' do
        searcher = described_class.new('ruby', 1, 20)
        expect(searcher.instance_variable_get(:@url)).to include 'title'
      end
    end

    context 'ISBNが12桁の場合' do
      it 'クエリストリングにtitleがあること' do
        searcher = described_class.new('978477419397', 1, 20)
        expect(searcher.instance_variable_get(:@url)).to include 'title'
      end
    end

    context 'ISBNが14桁の場合' do
      it 'クエリストリングにtitleがあること' do
        searcher = described_class.new('97847741939771', 1, 20)
        expect(searcher.instance_variable_get(:@url)).to include 'title'
      end
    end
  end

  describe '#run' do
    context '正しいISBNの場合' do
      it 'プロを目指す人のためのRuby入門の結果が返ること' do
        searcher = described_class.new('9784297124373', 1, 20).run
        expect(searcher['Items'][0]['Item']['title']).to eq 'プロを目指す人のためのRuby入門［改訂2版］　言語仕様からテスト駆動開発・デバッグ技法まで'
      end
    end

    context '正しいタイトルの場合' do
      it 'プロを目指す人のためのRuby入門の結果が返ること' do
        searcher = described_class.new('プロを目指す人のためのRuby入門', 1, 20).run
        expect(searcher['Items'][0]['Item']['title']).to eq 'プロを目指す人のためのRuby入門［改訂2版］　言語仕様からテスト駆動開発・デバッグ技法まで'
      end
    end

    context '存在しないISBNの場合' do
      it 'Items配列が空で返ること' do
        searcher = described_class.new('9780123456789', 1, 20).run
        expect(searcher['Items']).to eq []
      end
    end

    context '存在しないタイトルの場合' do
      it 'Items配列が空で返ること' do
        # APIのリクエスト制限に引っかかるのでいったん止める
        sleep 2
        searcher = described_class.new('プロを目指さない人のためのRuby入門', 1, 20).run
        expect(searcher['Items']).to eq []
      end
    end
  end
end
