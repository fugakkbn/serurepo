# frozen_string_literal: true

require 'crawler/amazon_crawler'
require 'crawler/dmm_crawler'
require 'crawler/rakuten_crawler'
require 'crawler/seshop_crawler'
require 'logger'

module Comparer
  class Books
    def self.run
      logger = Logger.new('log/crawler.log')
      logger << "==#{Time.current} Books Compare start==================\n"

      data = []
      Book.find_each do |book|
        amazon = AmazonCrawler.new
        dmm = DmmCrawler.new
        rakuten = RakutenCrawler.new
        seshop = SeshopCrawler.new

        amazon.run(book.isbn13)
        dmm.run(book.title)
        rakuten.run(book.isbn13)
        seshop.run(book.isbn13)

        data.push({ book_id: book.id,
                    amazon: amazon_comparer(amazon, book),
                    dmm: dmm_comparer(dmm, book),
                    rakuten: rakuten_comparer(rakuten, book),
                    seshop: seshop_comparer(seshop, book) })
      end

      logger << "【All Results】\n#{data}\n"

      data
    end

    def self.amazon_comparer(amazon_data, book)
      kindle = amazon_data.kindle_price
      paper = amazon_data.paper_price

      return if kindle.blank? && paper.blank?

      single = kindle.presence || paper
      price = if kindle.present? && paper.present?
                compare_price(kindle, paper)
              else
                single
              end

      return if price >= book.price

      { price: price,
        url: "https://www.amazon.co.jp/dp/#{amazon_data.asin}/ref=nosim?tag=#{Rails.application.credentials.amazon[:tag]}" }
    end

    def self.dmm_comparer(dmm_data, book)
      return if dmm_data.price.blank? || dmm_data.price >= book.price

      { price: dmm_data.price, url: dmm_data.book_url }
    end

    def self.rakuten_comparer(rakuten_data, book)
      e_book = rakuten_data.e_book_price
      paper = rakuten_data.paper_book_price
      single = rakuten_data.single_price

      return if single.blank?

      price = if e_book.present? && paper.present?
                compare_price(e_book, paper)
              else
                single
              end

      return if price >= book.price

      { price: price, url: book.url }
    end

    def self.seshop_comparer(seshop_data, book)
      return if seshop_data.paper_price.blank? && seshop_data.pdf_price.blank?

      seshop_price = seshop_data.paper_price.to_i
      seshop_url = seshop_data.paper_url

      pdf_price = seshop_data.pdf_price.to_i
      if !pdf_price.zero? && pdf_price < seshop_price
        seshop_price = pdf_price
        seshop_url = seshop_data.pdf_url
      end

      return if book.price <= seshop_price

      { price: seshop_price, url: seshop_url }
    end

    def self.compare_price(e_book_price, paper_price)
      if e_book_price == paper_price
        e_book_price
      elsif e_book_price < paper_price
        e_book_price
      elsif e_book_price > paper_price
        paper_price
      end
    end
  end
end
