# frozen_string_literal: true

class ListDetailsController < ApplicationController
  def destroy
    detail = ListDetail.find(params[:id])
    if detail.list.user == current_user
      detail.destroy
      redirect_to request.referer, notice: '削除しました。'
    else
      redirect_to request.referer, alert: '削除できませんでした。'
    end
  end
end
