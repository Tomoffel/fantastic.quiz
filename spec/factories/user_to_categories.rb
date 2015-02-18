FactoryGirl.define do
  factory :user_to_category do
    user_id 1
category_id 1

    factory :categoryWithoutUser do
      user_id nil
      category_id 1
    end
  end

end
