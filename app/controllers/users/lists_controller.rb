# frozen_string_literal: true

class Users::ListsController < ApplicationController
  before_action :require_self_list, only: %i[show]

  def show
    @list_id = params[:id]
    @books = ListDetail.where(list_id: @list_id).map(&:book)
  end

  private

  def require_self_list
    redirect_to root_path, alert: 'URLが不正です。' if current_user.list&.id != params[:id].to_i
  end
end
