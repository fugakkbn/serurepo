# frozen_string_literal: true

class API::ListDetails::IdController < API::BaseController
  def index
    book = Book.find_by(isbn13: params['isbn'])
    list = current_user.list
    list_detail = ListDetail.find_by(list_id: list&.id, book_id: book&.id)

    id = list_detail.present? ? list_detail.id : nil
    render status: :ok, json: { listDetailId: id }
  end
end
