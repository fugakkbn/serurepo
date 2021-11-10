# frozen_string_literal: true

class API::BooksController < API::BaseController
  def create
    book = Book.create_with(book_params).find_or_initialize_by(isbn13: params['book']['isbn13'])

    if book.new_record?
      if book.save
        render status: :created,
               json: { bookId: book.id }
      else
        render status: :unprocessable_entity,
               json: { errorMessage: '登録に失敗しました。' }
      end
    else
      render status: :ok, json: { bookId: book.id }
    end
  end

  private

  def book_params
    params.require(:book).permit(:isbn13, :price, :title, :author, :image, :url, :sales_date)
  end
end
