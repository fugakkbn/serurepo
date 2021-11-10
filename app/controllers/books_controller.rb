# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    if params[:query].present?
      @query = params[:query]
      @page_num = (params[:page] || 1).to_i
      count_per_page = 20

      response = RakutenBooksSearcher.new(@query, @page_num, count_per_page).run

      @max_page_num = response['pageCount']
      @total_num = response['count']
      @first_num = response['first']
      @last_num = response['last']
      @items = response['Items']

      render :index
    else
      redirect_to root_path, alert: '検索ワードを入力してください。'
    end
  end
end
