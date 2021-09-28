# frozen_string_literal: true

class Api::BooksController < ApplicationController
  def show
    if Book.find('isbn_13' => params['isbn_13']).present?
      render status: :ok, json: { bookId: book.id }
    else
      render status: :unprocessable_entity, json: { bookId: nil }
    end
  end

  def create
    isbn = params['isbn_13']

    unless Book.find_by('isbn_13' => isbn).nil?
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
