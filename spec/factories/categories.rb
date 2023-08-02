FactoryBot.define do
  factory :category do
    sequence(:name) {|x| "Category #{x}" }
  end
end
