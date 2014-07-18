# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lesson_element do
    lesson nil
    row_order 1
    pageable_id 1
    presentable_id 1
    presentable_type "MyString"
  end
end
