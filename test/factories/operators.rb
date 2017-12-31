FactoryBot.define do
  factory :operator do
    race
    association :host, factory: :michael
    association :oracle, factory: :john
  end
end
