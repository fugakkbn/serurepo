# frozen_string_literal: true

require_relative 'crawler'

class RakutenCrawler < Crawler
  attr_reader :single_price, :e_book_price, :paper_book_price, :book_url

  def initialize
    super
    @url = 'https://books.rakuten.co.jp/'
    @single_price = ''
    @e_book_price = ''
    @paper_book_price = ''
    @logger = Logger.new('log/crawler.log')
  end

  def run(isbn) # rubocop:disable Metrics/MethodLength
    data = []
    begin
      @logger << "-- Rakuten Crawler started at: #{Time.current}\n"
      start_scraping @url do
        fill_in id: 'searchWords', with: isbn
        find_by_id('searchBtn').click

        first('.rbcomp__item-list__item__details__lead').first('a').click

        sleep 5

        price = find('.productPrice span.price').text.delete(',円').to_i
        data << price

        price_list_dom = all('.linkOtherFormat ul .linkOtherFormat__list')

        next if price_list_dom.size.zero?

        e_book_price = price_list_dom[0].text.split(' ')[-1].delete(',円').to_i
        data << e_book_price

        paper_book_price = price_list_dom[1].text.split(' ')[-1].delete(',円').to_i
        data << paper_book_price
      end
    rescue StandardError => e
      @logger << "#{'*' * 30}\n"
      @logger << "*****Error caused Rakuten Crawler*****\n"
      @logger << "【Error Message isbn: #{isbn}】#{e.message}\n"
      @logger << "#{'*' * 30}\n"
    end

    @logger << "【Rakuten isbn: #{isbn}】#{data}\n"
    @logger << "-- Rakuten Crawler ended.\n"

    @single_price, @e_book_price, @paper_book_price = data
  end
end
