require 'rails_helper'

RSpec.describe License, type: :model do
  it { is_expected.to belong_to (:game) }
  it { is_expected.to validate_presence_of(:key) }
  it { is_expected.to validate_uniqueness_of(:key).case_insensitive }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to define_enum_for(:status).with_values({ available: 1, unavailable: 2 })}

  it_behaves_like "paginatable concern", :license
  
end
