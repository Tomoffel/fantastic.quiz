require 'rails_helper'

RSpec.describe "categories/edit", :type => :view do
  before(:each) do
    @category = assign(:category, FactoryGirl.create(:category))
    #todo add testcase with parent
    #@categoryWP = assign(:category, FactoryGirl.create(:categoryWithParent))
  end

  it "renders the edit category form" do
    render

    assert_select "form[action=?][method=?]", category_path(@category), "post" do
      assert_select "input#category_name[name=?]", "category[name]"
    end
    #assert_select "form[action=?][method=?]", category_path(@categoryWithParent), "post" do
    #  assert_select "input#category_name[name=?]", "category[name]"
    #  assert_select "input#category_parent_id[name=?]", "category[parent_id]"
    #end
  end
end
