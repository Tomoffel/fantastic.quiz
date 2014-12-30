require 'rails_helper'

RSpec.describe "questions/show", :type => :view do
  before(:each) do
    @question = assign(:question, Question.create!(
      :question => "Question"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Question/)
  end
end
