class CreateListDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :list_details do |t|
      t.belongs_to :list, foreign_key: true
      t.belongs_to :book, foreign_key: true

      t.timestamps
    end
  end
end
