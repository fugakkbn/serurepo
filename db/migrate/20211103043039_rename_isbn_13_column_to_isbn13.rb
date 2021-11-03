# frozen_string_literal: true

class RenameIsbn13ColumnToIsbn13 < ActiveRecord::Migration[6.1]
  def change
    rename_column :books, :isbn_13, :isbn13
  end
end
