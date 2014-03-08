# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :app do
    dataset_uris "MyString"
    challenge_url "MyString"
    codebase_url "MyString"
    demo_url "MyString"
    description "MyText"
    name "MyString"
    creators "MyText"
    organization "MyString"
    location "MyString"
  end
end
