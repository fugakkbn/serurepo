# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    if params[:query].present?
      @query = params[:query]
      @page_num = (params[:page] || 1).to_i
      count_per_page = 20

      url = "https://app.rakuten.co.jp/services/api/BooksBook/Search/20170404?format=json&hits=#{count_per_page}&affiliateId=#{Rails.application.credentials.rakuten[:af_id]}&applicationId=#{Rails.application.credentials.rakuten[:app_id]}&page=#{@page_num}"
      url += /^978[0-9]{10}/.match?(@query) ? "&isbn=#{@query}" : "&title=#{@query}"

      client = HTTPClient.new
      request = client.get(url)
      response = JSON.parse(request.body)

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
