# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :app do
    dataset_uris "dataset1,dataset2"
    challenge_url "challenge"
    codebase_url "http//github.com"
    demo_url "http://demo.url"
    sequence(:description) {|n| "description#{n}" }
    sequence(:name) {|n| "name#{n}" }
    creators "cmx"
    organization "codeandomexico"
    sequence(:location) {|n| "location#{n}" }
    logo_url "logo.png"
    visible true
    technologies "ruby,rails"
  end
end
