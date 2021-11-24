# frozen_string_literal: true

require 'rails_helper'
require_relative '../../lib/crawler/amazon_crawler'

RSpec.describe 'AmazonCrawler', type: :system do
  describe 'run' do
    let(:crawler) { AmazonCrawler.new }
    let(:book) { build(:perfect_rails) }
    let(:dokugaku) { build(:dokugaku) }

    it '金額は数値、ASINは10桁の文字列が返ってくること' do
      crawler.run(book.isbn13)
      expect(crawler.kindle_price).to be_integer
      expect(crawler.paper_price).to be_integer
      expect(crawler.asin.size).to eq 10
    end

    it 'audible版がある書籍でも0円にならないこと' do
      crawler.run(dokugaku.isbn13)
      expect(crawler.paper_price).not_to eq 0
    end
  end
end
