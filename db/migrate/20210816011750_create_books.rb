class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :isbn_13
      t.integer :price

      t.timestamps
    end
  end
end
