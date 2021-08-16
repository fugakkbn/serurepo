# frozen_string_literal: true

class ListDetail < ApplicationRecord
  belongs_to :book

  validates :list_id, presence: true, numericality: { only_integer: true }
  validates :book_id, presence: true, numericality: { only_integer: true }
end
