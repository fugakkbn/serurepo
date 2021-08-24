# frozen_string_literal: true

class Users::ListsController < ApplicationController
  before_action :require_self_list, only: %i[show]

  def create # rubocop:disable Metrics/MethodLength
    item = params[:list][:book]
    @isbn = item['isbn_13']
    @price = item[:price]
    @title = item[:title]
    @author = item[:author]
    @image = item[:image]
    @url = item[:url]
    @sales_date = item[:sales_date]

    if current_user.list.blank?
      @book_list = List.new(list_params)
      @book_list.save
    else
      @book_list = current_user.list
    end

    if Book.find_by('isbn_13' => @isbn).nil?
      @item = Book.new(book_params)
      @item.save
    else
      @item = Book.find_by('isbn_13' => @isbn)
    end

    unless ListDetail.find_by(list_id: @book_list.id, book_id: @item.id).nil?
      redirect_to request.referer, alert: 'すでに追加済みです。'
      return
    end

    list_detail = ListDetail.new(list_detail_params)
    if list_detail.save
      redirect_to request.referer, notice: 'リストに追加しました！'
    else
      redirect_to request.referer, alert: 'リストに追加できませんでした。'
    end
  end

  def show
    @list_id = params[:id]
    @books = ListDetail.where(list_id: @list_id).map(&:book)
  end

  def update; end

  private

  def require_self_list
    redirect_to root_path, alert: 'URLが不正です。' if current_user.list.id != params[:id].to_i
  end

  def list_params
    params.permit(:user_id, :name).merge(user_id: current_user.id)
  end

  def book_params
    params.permit('isbn_13', :price, :title, :author, :image, :url, :sales_date)
          .merge('isbn_13' => @isbn, price: @price, title: @title, author: @author, image: @image, url: @url, sales_date: @sales_date)
  end

  def list_detail_params
    params.permit(:list_id, :book_id).merge(list_id: @book_list.id, book_id: @item.id)
  end
end
