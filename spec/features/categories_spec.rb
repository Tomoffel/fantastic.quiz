require 'rails_helper'

describe 'Test gui components' do
  before(:all) do

    question1 = Question.create(question: 'Was ist nicht Bestandteil des Umlaufvermögens?')
    Answer.create(answer: 'Roh - Hilfs - und Betriebsstoffe', question_id: question1.id)
    Answer.create(answer: 'Gewinnrücklagen', question_id: question1.id, correctAnswer: 't')

    question2 = Question.create(question: 'Was ist final int MAX_CIRCLES = 100 für ein Variablentyp?')
    Answer.create(answer: 'Konstante', question_id: question2.id, correctAnswer: 't')
    Answer.create(answer: 'Klassenvariable', question_id: question2.id)
    Answer.create(answer: 'Parameter', question_id: question2.id)

    question3 = Question.create(question: 'Wie nennt man die Anpassung bzw. Aktualisierung von Software-Versionen?')
    Answer.create(answer: 'Backup', question_id: question3.id)
    Answer.create(answer: 'Ripping', question_id: question3.id)
    Answer.create(answer: 'Update', question_id: question3.id, correctAnswer: 't')

    question4 = Question.create(question: 'Was gehört nicht zur Hardware?')
    Answer.create(answer: 'Maus', question_id: question4.id)
    Answer.create(answer: 'RAM-Speicher', question_id: question4.id)
    Answer.create(answer: 'Harddiskdriver', question_id: question4.id, correctAnswer: 't')

    question5 = Question.create(question: 'Ein eigens für ein Unternehmen oder eine Gruppe aufgestelltes Netzwerk mit Internet-Technologie nennt sich?')
    Answer.create(answer: 'Telnet', question_id: question5.id)
    Answer.create(answer: 'WAN', question_id: question5.id)
    Answer.create(answer: 'Intranet', question_id: question5.id, correctAnswer: 't')
    Answer.create(answer: 'Chat', question_id: question5.id)

    question6 = Question.create(question: 'Wie wird die Summe aller Sachgüter und Dienstleistungen, die in einer Volkswirtschaft im Laufe eines Jahres geschaffen werden, bezeichnet?')
    Answer.create(answer: 'Bruttosozialprodukt', question_id: question6.id, correctAnswer: 't')
    Answer.create(answer: 'Lebensstandard', question_id: question6.id)
    Answer.create(answer: 'Volksvermögen', question_id: question6.id)
    Answer.create(answer: 'Gesamtbedarf', question_id: question6.id)

    question7 = Question.create(question: 'Was ist keine Individualversicherung?')
    Answer.create(answer: 'private Krankenversicherung', question_id: question7.id)
    Answer.create(answer: 'Lebensversicherung', question_id: question7.id)
    Answer.create(answer: 'Kfz-Versicherung', question_id: question7.id)
    Answer.create(answer: 'betriebliche Unfallversicherung', question_id: question7.id, correctAnswer: 't')


    adminUser = User.create(email: "admin@admin.de", password: 'adminadmin', password_confirmation: 'adminadmin')
    adminUser.add_role :admin

  end

  after(:all) do
    Category.destroy_all
    User.destroy_all
    Question.destroy_all
    Answer.destroy_all
    CategoryToQuestion.destroy_all
  end
  it 'should create, edit, show, destroy some categories' do
    visit '/users/sign_in'
    fill_in 'user_email', with: 'admin@admin.de'
    fill_in 'user_password', with: 'adminadmin'
    click_button 'Sign in'
    page.should have_content 'Signed in successfully.'

    click_link 'Create a new category'

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

    fill_in 'category[name]', with: 'VWL'
    click_button 'Save'

    page.should have_content "Category was successfully updated."
  end


end

