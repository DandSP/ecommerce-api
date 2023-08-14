FactoryBot.define do
  factory :admin_v1_license, class: 'Admin::V1::License' do
    key { "MyString" }
    game_id { "MyString" }
  end
end
