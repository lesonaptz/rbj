FactoryGirl.define do
    # Define a basic devise user.
    factory :contact do
        email "lesonapt@gmail.com"
        name "lesonapt"
        phone "0984690612"
        content "some text"
    end
end
