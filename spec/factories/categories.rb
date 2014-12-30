FactoryGirl.define do
  factory :category do
    name "Testcategory"
    parent_id nil

    factory :categoryWithParent do
      name "Testcategory2"
      parent_id 1

      factory :categoryWithoutName do
        name nil
        parent_id 1
      end
    end
  end
end