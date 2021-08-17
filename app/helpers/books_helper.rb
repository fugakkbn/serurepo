# frozen_string_literal: true

module BooksHelper
  def registered?(isbn)
    book = Book.find_by('isbn_13' => isbn)
    list = current_user.list
    list_detail = ListDetail.find_by(list_id: list&.id, book_id: book&.id)
    list_detail.present?
  end
end
