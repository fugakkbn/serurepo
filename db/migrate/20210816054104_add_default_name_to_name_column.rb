class AddDefaultNameToNameColumn < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:lists, :name, '通知リスト')
  end
end
