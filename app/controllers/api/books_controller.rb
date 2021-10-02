# frozen_string_literal: true

class Api::BooksController < ApplicationController
  def create
    isbn = params['book']['isbn_13']

    if Book.find_by('isbn_13' => isbn).present?
      book = Book.find_by('isbn_13' => isbn)
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
    params.require(:book).permit('isbn_13', :price, :title, :author, :image, :url, :sales_date)
  end
end
