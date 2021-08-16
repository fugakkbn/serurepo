# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :list_details, dependent: :destroy

  validates 'isbn_13', presence: true, length: { is: 13 }
  validates :price, presence: true, numericality: { only_integer: true }
end
