require 'rails_helper'

RSpec.describe "categories/index", :type => :view do
  before(:each) do
    assign(:categories, [
      FactoryGirl.create(:category),
     # FactoryGirl.create(:categoryWithParent)
    ])
  end

  it "renders a list of categories" do
    render
    assert_select "tr>td", :text => "Testcategory".to_s, :count => 1
    assert_select "tr>td", :text => "".to_s, :count => 1
  end
end
