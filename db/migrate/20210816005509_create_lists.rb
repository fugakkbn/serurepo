class CreateLists < ActiveRecord::Migration[6.1]
  def change
    create_table :lists do |t|
      t.belongs_to :user, index: { unique: true }, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
