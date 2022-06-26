# frozen_string_literal: true

class API::Users::ListsController < API::BaseController
  def show
    list_id = params[:id]
    @list_details = ListDetail.where(list_id:)
  end

  def create
    list = List.create_with(list_params).find_or_initialize_by(user: current_user)

    if list.new_record?
      if list.save
        render status: :created, json: { listId: list.id }
      else
        render status: :unprocessable_entity, json: { errorMessage: '登録に失敗しました。' }
      end
    else
      render status: :ok, json: { listId: list.id }
    end
  end

  private

  def list_params
    params.permit(:user_id).merge(user_id: current_user.id)
  end
end
