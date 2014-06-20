# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question_attempt_response do
    question_attempt nil
    user_id nil
    note "MyText"
    mark_start "MyString"
    mark_end "MyString"
  end
end
