# frozen_string_literal: true

class API::BooksController < API::BaseController
  def create
    isbn = params['book']['isbn13']

    if Book.find_by(isbn13: isbn).present?
      book = Book.find_by(isbn13: isbn)
      render status: :ok, json: { bookId: book.id }
      return
    end

    book = Book.new(book_params)
    if book.save
      render status: :created,
             json: { bookId: book.id }
    else
      render status: :unprocessable_entity,
             json: { errorMessage: '登録に失敗しました。' }
    end
  end

  private

  def book_params
    params.require(:book).permit(:isbn13, :price, :title, :author, :image, :url, :sales_date)
  end
end
