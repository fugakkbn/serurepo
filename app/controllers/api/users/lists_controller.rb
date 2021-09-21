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
  end
end
