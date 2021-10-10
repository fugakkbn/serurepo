# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :list_details, dependent: :destroy
  has_many :lists, through: :list_details

  validates 'isbn_13', presence: true, length: { is: 13 }
  validates :price, presence: true, numericality: { only_integer: true }
  validates :title, presence: true
  validates :author, presence: true
  validates :image, presence: true
  validates :url, presence: true
  validates :sales_date, presence: true
end
