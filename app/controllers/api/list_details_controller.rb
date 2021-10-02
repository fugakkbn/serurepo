# frozen_string_literal: true

class Api::ListDetailsController < ApplicationController
  def create
    list_detail = params['list_detail']

    if ListDetail.find_by(list_id: list_detail['list_id'], book_id: list_detail['book_id']).present?
      render status: :bad_request, json: { errorMessage: 'すでに登録済みです。' }
      return
    end

    list_detail = ListDetail.new(list_detail_params)
    if list_detail.save
      render status: :created,
             json: { message: 'リストに追加しました！' }
    else
      render status: :unprocessable_entity,
             json: { errorMessage: list_detail.errors.full_messages }
    end
  end

  private

  def list_detail_params
    params.require(:list_detail).permit(:list_id, :book_id)
  end
end
