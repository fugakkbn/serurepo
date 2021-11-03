# frozen_string_literal: true

class API::Users::ListsController < API::BaseController
  def show
    @list_id = params[:id]
    @list_details = ListDetail.where(list_id: @list_id)
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
