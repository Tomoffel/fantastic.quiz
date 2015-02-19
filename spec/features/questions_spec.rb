require 'rails_helper'

describe 'Test Question' do

  before(:all) do
    adminUser = User.create(email: "admin@admin.de", password: 'adminadmin', password_confirmation: 'adminadmin')
    adminUser.add_role :admin
  end
  it 'should create, edit, show, destroy some questions' do
    visit '/users/sign_in'
    fill_in 'user_email', with: 'admin@admin.de'
    fill_in 'user_password', with: 'adminadmin'
    click_button 'Sign in'
    page.should have_content 'Signed in successfully.'

    click_link 'Create a new question'

    fill_in 'question[question]', with: 'Frage'
    fill_in 'question[answers1]', with: 'ans1'
    fill_in 'question[answers2]', with: 'ans2'
    choose('question_correctMethod_correct1')
    click_button 'Save'

    page.should have_content 'Question successfully created!'
    page.should have_content 'Frage'

    click_link 'Questions overview'

    click_link 'Edit'
    fill_in 'question[question]', with: 'Frage1'
    fill_in 'question[answers1]', with: 'ans3'
    choose('question_correctMethod_correct1')
    click_button 'Save'
    page.should have_content 'Question successfully updated!'
    click_link 'Questions overview'

    click_link('Destroy', match: :first)
    page.should have_content 'Question successfully deleted!'

  end
end