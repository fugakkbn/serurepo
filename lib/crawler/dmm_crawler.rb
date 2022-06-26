# frozen_string_literal: true

require_relative 'crawler'

class DmmCrawler < Crawler
  attr_reader :price, :book_url

  def initialize
    super
    @url = 'https://book.dmm.com/search/?service=ebook&searchstr='
    @price = ''
    @book_url = ''
    @logger = Logger.new('log/crawler.log')
  end

  def run(book_title) # rubocop:disable Metrics/MethodLength
    url = @url + book_title
    data = []
    begin
      @logger << "-- DMM Crawler started at: #{Time.current}\n"
      start_scraping url do
        next unless all('p', text: '一致する商品は見つかりませんでした。').size.zero?

        find('#fn-list').first('a').click

        price = find('.m-boxSubDetailPurchase__price')
                .text
                .split[1]
                .delete(',円')
                .to_i

        data << price
        data << current_url
      end
    rescue StandardError => e
      @logger << "#{'*' * 30}\n"
      @logger << "*****Error caused DMM Crawler*****\n"
      @logger << "【Error Message title: #{book_title}】#{e.message}\n"
      @logger << "#{'*' * 30}\n"
    end

    @logger << "【DMM title: #{book_title}】#{data}\n"
    @logger << "-- DMM Crawler ended.\n"

    @price, @book_url = data
  end
end
