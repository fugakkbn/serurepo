# frozen_string_literal: true

class API::BooksController < API::BaseController
  def create
    isbn = params['book']['isbn13']
    book = Book.find_by(isbn13: isbn)

    if book.present?
      render status: :ok, json: { bookId: book.id }
      return
    end

    new_book = Book.new(book_params)
    if new_book.save
      render status: :created,
             json: { bookId: new_book.id }
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
