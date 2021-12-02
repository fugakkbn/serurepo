# frozen_string_literal: true

require 'rails_helper'
require_relative '../../lib/crawler/seshop_crawler'

RSpec.describe 'SeshopCrawler', type: :system do
  describe 'run' do
    let(:crawler) { SeshopCrawler.new }

    context '紙版、PDF版ともにある書籍の場合' do
      let(:book) { build(:dokusyu_js) }

      it 'それぞれの金額が数値、URLもあること' do
        crawler.run(book.isbn13)
        expect(crawler.paper_price).to be_integer
        expect(crawler.pdf_price).to be_integer
        expect(crawler.paper_url).to include('https://www.seshop.com/product/detail/')
        expect(crawler.pdf_url).to include('https://www.seshop.com/product/detail/')
      end
    end

    context '紙版のみの書籍の場合' do
      let(:book) { build(:kumikomi_os) }

      it '紙版は金額とURLがあり、pdf版はそれぞれ空文字であること' do
        crawler.run(book.isbn13)
        expect(crawler.paper_price).to be_integer
        expect(crawler.paper_url).to include('https://www.seshop.com/product/detail/')
        expect(crawler.pdf_price).to be_blank
        expect(crawler.pdf_url).to be_blank
      end
    end

    context '販売されていない書籍の場合' do
      let(:book) { build(:perfect_rails) }

      it 'すべて空文字であること' do
        crawler.run(book.isbn13)
        expect(crawler.paper_price).to be_blank
        expect(crawler.paper_url).to be_blank
        expect(crawler.pdf_price).to be_blank
        expect(crawler.pdf_url).to be_blank
      end
    end
  end
end
