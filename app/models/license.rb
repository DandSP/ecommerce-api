class License < ApplicationRecord
  validates :key, presence: true, uniqueness: { case_sensitive: false }
  validates :status, presence: true
  belongs_to :game

  enum status: { available: 1, unavailable: 2}

  include Paginatable
end
