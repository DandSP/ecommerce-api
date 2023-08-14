require 'rails_helper'

RSpec.describe License, type: :model do
  it { is_expected.to belong_to (:game) }
  it { is_expected.to validate_presence_of(:key) }
  it { is_expected.to validate_uniqueness_of(:key).case_insensitive }
  it { is_expected.to validate_presence_of(:game_id) }
  it { is_expected.to validate_uniqueness_of(:game_id).case_insensitive }

end
