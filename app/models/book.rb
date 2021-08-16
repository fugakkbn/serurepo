# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :list_details, dependent: :destroy
end
