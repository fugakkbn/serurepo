# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    @query = params[:query]
    @page_num = (params[:page] || 1).to_i

    url = "https://app.rakuten.co.jp/services/api/BooksBook/Search/20170404?format=json&hits=20&affiliateId=#{ENV['RAKUTEN_AF_ID']}&applicationId=#{ENV['RAKUTEN_APP_ID']}&page=#{@page_num}"
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
  end
end
