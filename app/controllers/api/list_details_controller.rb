# frozen_string_literal: true

class API::ListDetailsController < API::BaseController
  def create
    list_detail = params['list_detail']
    new_detail = ListDetail.create_with(list_detail_params)
                           .find_or_initialize_by(list_id: list_detail['list_id'], book_id: list_detail['book_id'])

    if new_detail.new_record?
      if new_detail.save
        render status: :created,
               json: { message: 'リストに追加しました！' }
      else
        render status: :unprocessable_entity,
               json: { errorMessage: new_detail.errors.full_messages }
      end
    else
      render status: :bad_request, json: { errorMessage: 'すでに登録済みです。' }
    end
  end

  def destroy
    list_detail = ListDetail.find(params[:id])

    if list_detail.destroy
      list_detail.book.not_in_list_details_destroy!

      render status: :ok,
             json: { successMessage: '削除しました。' }
    else
      render status: :unprocessable_entity,
             json: { errorMessage: '削除できませんでした。' }
    end
  end

  private

  def list_detail_params
    params.require(:list_detail).permit(:list_id, :book_id)
  end
end
