FactoryGirl.define do
    # Define a basic devise user.
    factory :user do
        email "lesonapt@gmail.com"
        password "laslas123"
        password_confirmation "laslas123"
    end
end
