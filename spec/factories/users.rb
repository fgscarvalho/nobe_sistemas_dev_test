FactoryBot.define do
    factory :user do
        email {Faker::Internet.email}
        first_name {Faker::Name.first_name}
        last_name {Faker::Name.last_name}
        cpf {Faker::IDNumber.brazilian_citizen_number}
        password {Faker::Internet.password(min_length: 6)}
    end
end
