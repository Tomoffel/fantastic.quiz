require 'rails_helper'

describe 'Test Question' do

  it 'should create, edit, show, destroy some questions' do
    #todo maybe sign in first
    visit '/questions'

    click_link 'New Question'

    fill_in 'question[question]', with: 'Frage'
    fill_in 'question[answers1]', with: 'ans1'
    fill_in 'question[answers2]', with: 'ans2'
    # TODO click_button 'question_correctMethod_correct1'
    click_button 'Save'

    page.should have_content 'Question successfully created!'
    page.should have_content 'Frage'

    click_link('Show', match: :first)

    page.should have_content 'Question: Frage'
    click_link 'Back'

    click_link 'Edit'
    fill_in 'question[question]', with: 'Frage1'
    fill_in 'question[answers1]', with: 'ans3'
    # TODO click_button 'question[correctMethod]', match: :first
    click_button 'Save'
    page.should have_content 'Question successfully updated!'
    click_link 'Back'

    click_link('Destroy', match: :first)
    page.should have_content 'Question successfully deleted!'

  end
end