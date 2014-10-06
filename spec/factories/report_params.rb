# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :report_params do
    report nil
    query_param nil
    value "MyString"
    editable false
  end
end
