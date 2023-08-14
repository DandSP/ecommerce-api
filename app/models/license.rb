class License < ApplicationRecord
  validates :key, presence: true, uniqueness: { case_sensitive: false }
  validates :game_id, presence: true, uniqueness: { case_sensitive: false }
  belongs_to :game
end
