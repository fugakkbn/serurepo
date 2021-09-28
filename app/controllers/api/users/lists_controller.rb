# frozen_string_literal: true

class Api::Users::ListsController < ApplicationController
  def show
    @list_id = params[:id]
    @books = ListDetail.where(list_id: @list_id).map do |detail|
      {
        list_detail_id: detail.id,
        book: detail.book
      }
    end

    render status: :ok, json: { books: @books }
  end

  def create
    if current_user.list.present?
      list = current_user.list
      render status: :ok, json: { listId: list.id }
      return
    end

    list = List.new(list_params)
    if list.save
      render status: :created, json: { listId: list.id }
    else
      render status: :unprocessable_entity, json: { errorMessage: '登録に失敗しました。' }
    end
  end

  private

  def list_params
    params.permit(:user_id).merge(user_id: current_user.id)
  end
end
