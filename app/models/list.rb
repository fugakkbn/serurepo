# frozen_string_literal: true

class List < ApplicationRecord
  belongs_to :user
  has_many :list_details, dependent: :destroy
  has_many :books, through: :list_details

  validates :user_id, presence: true, numericality: { only_integer: true }
end
