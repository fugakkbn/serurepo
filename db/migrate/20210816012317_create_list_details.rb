class CreateListDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :list_details do |t|
      t.integer :list_id
      t.integer :book_id

      t.timestamps
    end
  end
end
