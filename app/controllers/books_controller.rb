# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    if params[:query].present?
      @query = params[:query]
      @page_num = (params[:page] || 1).to_i

      # APIの仕様上ページ指定は100が上限
      return redirect_to root_path, alert: 'パラメーターが不正です。' unless @page_num.between?(1, 100)

      count_per_page = 20

      response = RakutenBooksSearcher.new(@query, @page_num, count_per_page).run

      @max_page_num = response['pageCount']
      @total_num = response['count']
      @first_num = response['first']
      @last_num = response['last']
      @items = response['Items']
    else
      redirect_to root_path, alert: '検索ワードを入力してください。'
    end
  end
end
