require 'rails_helper'

RSpec.describe "questions/edit", :type => :view do
  before(:each) do
    @question = assign(:question, Question.create!(
      :question => "MyString"
    ))
  end

  it "renders the edit question form" do
    render

    assert_select "form[action=?][method=?]", question_path(@question), "post" do

      assert_select "input#question_question[name=?]", "question[question]"
    end
  end
end
