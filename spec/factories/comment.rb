FactoryGirl.define do
  factory :comment do
    post_id   { SecureRandom.uuid }
    user_id   { SecureRandom.uuid }
    body      "This is great!"
  end
end
