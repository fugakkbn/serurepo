# frozen_string_literal: true

require 'rails_helper'
require_relative '../../lib/crawler/amazon_crawler'

RSpec.describe 'AmazonCrawler', type: :system do
  describe 'run' do
    let(:crawler) { AmazonCrawler.new }
    let(:book) { build(:perfect_rails) }

    it '金額は数値、ASINは10桁の文字列が返ってくること' do
      crawler.run(book.isbn_13)
      expect(crawler.kindle_price).to be_integer
      expect(crawler.paper_price).to be_integer
      expect(crawler.asin.size).to eq 10
    end
  end
end
