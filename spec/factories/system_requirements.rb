FactoryBot.define do
  factory :system_requirement do
    sequence(:name) { |x| "MyString #{x}"}
    operational_system { Faker::Computer.os }
    storage { "10GB" }
    processor { "Ryzen 5600x" }
    memory { "8GB" }
    video_board { "RTX 4090" }
  end
end
