# frozen_string_literal: true

require_relative 'crawler'

class AmazonCrawler < Crawler
  attr_reader :kindle_price, :paper_price, :asin

  def initialize
    super
    @url = 'https://www.amazon.co.jp/'
    @kindle_price = ''
    @paper_price = ''
    @asin = ''
    @logger = Logger.new('log/crawler.log')
  end

  def run(isbn) # rubocop:disable Metrics/MethodLength
    data = []
    begin
      @logger << "-- Amazon Crawler started at: #{Time.current}\n"
      start_scraping @url do
        fill_in 'twotabsearchtextbox', with: isbn
        find('#nav-search-submit-button').click
        within 'h2.a-size-mini.a-spacing-none.a-color-base' do
          find('.a-link-normal.a-text-normal').click
        end

        switch_to_window(windows.last)

        ver_list_dom = all('.a-unordered-list.a-nostyle.a-button-list.a-horizontal li')

        kindle_price = ver_list_dom[0].text.split("\n")[1].delete('￥,').to_i
        data << kindle_price

        paper_price = ver_list_dom[-1].text.split("\n")[1].delete('￥,').to_i
        data << paper_price

        ver_list_dom[0].click

        split_url = current_url.split('/')
        before_target_index = split_url.index('dp')
        data << split_url[before_target_index.next]
      end
    rescue StandardError => e
      @logger << "#{'*' * 30}\n"
      @logger << "*****Error caused Amazon Crawler*****\n"
      @logger << "【Error Message isbn: #{isbn}】#{e.message}\n"
      @logger << "#{'*' * 30}\n"
    end

    @logger << "【Amazon isbn: #{isbn}】#{data}\n"
    @logger << "-- Amazon Crawler ended.\n"

    @kindle_price, @paper_price, @asin = data
  end
end
