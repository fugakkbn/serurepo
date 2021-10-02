# frozen_string_literal: true

class AddDiscountRatingToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :discount_rating, :integer, null:false, default: 1, limit: 8
  end
end
