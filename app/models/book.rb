# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :list_details, dependent: :destroy
  has_many :lists, through: :list_details

  validates :isbn13, presence: true, length: { is: 13 }
  validates :price, presence: true, numericality: { only_integer: true }
  validates :title, presence: true
  validates :image, presence: true
  validates :url, presence: true

  def not_in_list_details_destroy!
    destroy! if list_details.empty?
  end
end
