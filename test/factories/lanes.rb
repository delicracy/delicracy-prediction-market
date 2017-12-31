FactoryBot.define do
  factory :lane do
    title "Example Lane"
    description "This is a example lane."
    # association :race, factory: :race, strategy: :create
    race
  end
end
