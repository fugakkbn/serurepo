# frozen_string_literal: true

module BooksHelper
  def format_price(price)
    price = price.to_i
    return '情報なし' if price.zero?

    price = price.to_fs(:delimited)
    "#{price}円"
  end
end
