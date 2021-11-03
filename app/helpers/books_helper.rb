# frozen_string_literal: true

module BooksHelper
  def registered?(isbn, user)
    book = Book.find_by(isbn13: isbn)
    list = user.list
    list_detail = ListDetail.find_by(list_id: list&.id, book_id: book&.id)
    list_detail.present?
  end

  def format_price(price)
    price = price.to_i
    return '情報なし' if price.zero?

    price = price.to_s(:delimited)
    "#{price}円"
  end
end
