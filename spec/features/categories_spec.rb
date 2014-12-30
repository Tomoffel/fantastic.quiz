require 'rails_helper'

describe 'Test gui components' do

  it 'should create, edit, show, destroy some categories' do
    #todo maybe sign in first
    visit '/categories'

    click_link 'New Category'

    fill_in 'category[name]', with: 'BWL'
    click_button 'Save'

    page.should have_content 'Category was successfully created.'
    page.should have_content 'BWL'

    click_link 'New Category'

    fill_in 'category[name]', with: 'Rewe'
    select 'BWL', :from => 'category[parent_id]'
    click_button 'Save'

    page.should have_content 'Category was successfully created.'
    page.should have_content 'Rewe'
    page.should have_content 'BWL'

    click_link('Show', match: :first)

    page.should have_content 'Category: BWL'
    click_link 'Back'

    click_link('Destroy', match: :first)
    page.should have_content 'Category can not destroyed because it is a parent category.'

    page.all('a', :text => 'Destroy')[1].click
    page.should have_content 'Category was successfully destroyed.'

    click_link 'Edit'
    fill_in 'category[name]', with: ''
    click_button 'Save'
    page.should have_content "1 error prohibited this category from being saved:"

    fill_in 'category[name]', with: 'IT'
    click_button 'Save'

    page.should have_content "Category was successfully updated."
  end
end