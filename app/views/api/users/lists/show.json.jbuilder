json.books do
  json.array!(@list_details) do |detail|
    json.list_detail_id detail.id
    json.book do
      book = detail.book
      json.id book.id
      json.isbn13 book.isbn13
      json.price book.price
      json.title book.title
      json.author book.author
      json.image book.image
      json.url book.url
      json.sales_date book.sales_date
    end
  end
end
