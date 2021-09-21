json.books do
  json.array!(@books) do |book|
    json.list_detail_id book[:list_detail_id]
    json.book book[:book]
  end
end
