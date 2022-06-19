# frozen_string_literal: true

require_relative 'crawler'

class SeshopCrawler < Crawler
  attr_reader :pdf_price, :paper_price, :pdf_url, :paper_url

  def initialize
    super
    @search_url = 'https://www.seshop.com/search?keyword='
    @pdf_price = ''
    @paper_price = ''
    @paper_url = ''
    @logger = Logger.new('log/crawler.log')
  end

  def run(isbn) # rubocop:disable Metrics/MethodLength
    url = @search_url + isbn
    data = []
    begin
      @logger << "-- SEShop Crawler started at: #{Time.current}\n"
      start_scraping url do
        return data << nil if find('.row.list').text == '該当の商品はありません。'

        if find('h1').text.include?('検索結果一覧')
          within('.row.list') { first('figure').click }
          data << SeshopCrawler.calc_price_and_get_url(self)

          visit url
          within('.row.list') { all('figure').last.click }
          data << SeshopCrawler.calc_price_and_get_url(self)
        else
          data << SeshopCrawler.calc_price_and_get_url(self) << nil
        end
      end
    rescue StandardError => e
      @logger << "#{'*' * 30}\n"
      @logger << "*****Error caused SEShop Crawler*****\n"
      @logger << "【Error Message isbn: #{isbn}】#{e.message}\n"
      @logger << "#{'*' * 30}\n"
    end

    data.flatten!

    @logger << "【SEShop isbn: #{isbn}】#{data}\n"
    @logger << "-- SEShop Crawler ended.\n"

    @paper_price, @paper_url, @pdf_price, @pdf_url = data
  end

  def self.calc_price_and_get_url(crawler)
    discount = crawler.first('p', text: 'ポイント')
    discount = discount.text
                       .match('\d{1,3}(,\d{3})*')[0]
                       .delete(',')
                       .to_i

    price = crawler.find('.detail-price')
                   .text
                   .delete(',￥')
                   .to_i
    price -= discount

    [price, crawler.current_url]
  end
end
