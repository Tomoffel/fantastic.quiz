require 'rails_helper'

RSpec.describe "questions/index", :type => :view do
  before(:each) do
    assign(:questions, [
      Question.create!(
        :question => "Question"
      ),
      Question.create!(
        :question => "Question"
      )
    ])
  end

  it "renders a list of questions" do
    render
    assert_select "tr>td", :text => "Question".to_s, :count => 2
  end
end
