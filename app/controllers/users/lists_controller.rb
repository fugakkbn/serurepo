# frozen_string_literal: true

class Users::ListsController < ApplicationController
  def create  # rubocop:disable Metrics/MethodLength
    @isbn = params[:list][:book]['isbn_13']
    @price = params[:list][:book][:price]

    if current_user.list.blank?
      book_list = List.new(list_params)
      book_list.save
    end

    if Book.find_by('isbn_13' => @isbn).nil?
      @item = Book.new(book_params)
      @item.save
    else
      @item = Book.find_by('isbn_13' => @isbn)
    end

    unless ListDetail.find_by(list_id: current_user.list.id, book_id: @item.id).nil?
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

  def show; end

  def update; end

  private

  def list_params
    params.permit(:user_id, :name).merge(user_id: current_user.id)
  end

  def book_params
    params.permit('isbn_13', :price).merge('isbn_13' => @isbn, price: @price)
  end

  def list_detail_params
    params.permit(:list_id, :book_id).merge(list_id: current_user.list.id, book_id: @item.id)
  end
end
