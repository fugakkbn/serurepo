class AddTitleAndAuthorAndImageAndUrlAndSalesDateToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :title, :text
    add_column :books, :author, :text
    add_column :books, :image, :text
    add_column :books, :url, :text
    add_column :books, :sales_date, :text
  end
end
