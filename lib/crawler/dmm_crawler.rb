# frozen_string_literal: true

require_relative 'crawler'

class DmmCrawler < Crawler
  attr_reader :price, :book_url

  def initialize
    super
    @url = 'https://book.dmm.com/'
    @price = ''
    @book_url = ''
  end

  def run(book_title)
    data = []
    start_scraping @url do
      fill_in id: 'naviapi-search-text', with: book_title
      find('#naviapi-search-submit').click

      next unless all('p', text: '一致する商品は見つかりませんでした。').size.zero?

      find('#fn-list').first('a').click

      price = find('.m-boxSubDetailPurchase__price')
              .text
              .split(' ')[1]
              .delete(',円')
              .to_i

      data << price
      data << current_url
    end
    @price, @book_url = data
  end
end
