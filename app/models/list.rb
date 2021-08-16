# frozen_string_literal: true

class List < ApplicationRecord
  belongs_to :user
  has_many :list_details, dependent: :destroy
end
