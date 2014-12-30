require 'rails_helper'

RSpec.describe "categories/show", :type => :view do
  before(:each) do
    @category = assign(:category,FactoryGirl.create(:category))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Testcategory/)
    expect(rendered).to match(//)
  end
end
