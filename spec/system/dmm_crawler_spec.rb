# frozen_string_literal: true

require 'rails_helper'
require_relative '../../lib/crawler/dmm_crawler'

RSpec.describe 'DmmCrawler', type: :system do
  describe 'run' do
    let(:crawler) { DmmCrawler.new }
    let(:book) { build(:perfect_rails) }

    it '金額は数値、URLはhttps://book.dmm.com/detail/から始まること' do # rubocop:disable RSpec/MultipleExpectations
      crawler.run(book.title)
      expect(crawler.price).to be_integer
      expect(crawler.book_url).to be_include 'https://book.dmm.com/detail/'
    end
  end
end
