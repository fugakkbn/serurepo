# frozen_string_literal: true

class Api::ListDetails::IdController < ApplicationController
  def index
    book = Book.find_by('isbn_13' => params['isbn'])
    list = current_user.list
    list_detail = ListDetail.find_by(list_id: list&.id, book_id: book&.id)

    if list_detail.present?
      render status: :ok, json: { listDetailId: list_detail.id }
    else
      render status: :unprocessable_entity, json: { listDetailId: nil }
    end
  end
end
