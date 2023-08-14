class License < ApplicationRecord
  validates :key, presence: true, uniqueness: { case_sensitive: false }
  validates :game_id, presence: true, uniqueness: { case_sensitive: false }
  belongs_to :game

  enum status: { available: 1, unavailable: 2}
end
