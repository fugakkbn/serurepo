# frozen_string_literal: true

require 'rails_helper'
require_relative '../../lib/crawler/rakuten_crawler'

RSpec.describe 'RakutenCrawler', type: :system do
  describe 'run' do
    let(:crawler) { RakutenCrawler.new }
    let(:book) { build(:perfect_rails) }

    it '全ての金額が数値で返ってくること' do
      crawler.run(book.isbn13)
      expect(crawler.single_price).to be_integer
      expect(crawler.e_book_price).to be_integer
      expect(crawler.paper_book_price).to be_integer
    end
  end
end
