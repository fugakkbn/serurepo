# frozen_string_literal: true

class RakutenBooksSearcher
  def initialize(query, page_num, count_per_page)
    uri = URI('https://app.rakuten.co.jp/services/api/BooksBook/Search/20170404')
    uri.query = {
      format: :json,
      hits: count_per_page,
      affiliateId: Rails.application.credentials.rakuten[:af_id],
      applicationId: Rails.application.credentials.rakuten[:app_id],
      page: page_num,
      (/^978[0-9]{10}/.match?(query) ? :isbn : :title) => query
    }.to_query
    @url = uri.to_s
  end

  def run
    client = HTTPClient.new
    request = client.get(@url)
    JSON.parse(request.body)
  end
end
