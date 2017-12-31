FactoryBot.define do
  factory :user do
    name "Sample User"
    email { "#{name.parameterize}@example.com" }
    password "password"
  end

  factory :michael, class: User do
    name "Michael"
    email "michael@example.com"
    password 'password'
  end

  factory :john, class: User do
    name "John Doe"
    email "john@example.com"
    password 'password'
  end
end
