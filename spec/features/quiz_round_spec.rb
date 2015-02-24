require 'rspec'

describe 'Test gui components-Quiz' do
  before(:all) do
    it = Category.create(name: 'IT')
    question5 = Question.create(question: 'Ein eigens für ein Unternehmen oder eine Gruppe aufgestelltes Netzwerk mit Internet-Technologie nennt sich?')
    Answer.create(answer: 'Telnet', question_id: question5.id)
    Answer.create(answer: 'WAN', question_id: question5.id)
    Answer.create(answer: 'Intranet', question_id: question5.id, correctAnswer: 't')
    Answer.create(answer: 'Chat', question_id: question5.id)
    CategoryToQuestion.create(question_id: question5.id, category_id: it.id)

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

  it 'starts a new Quiz' do
    visit '/users/sign_in'
    fill_in 'user_email', with: 'admin@admin.de'
    fill_in 'user_password', with: 'adminadmin'
    click_button 'Sign in'
    page.should have_content 'Signed in successfully.'

    click_link('Start a quiz', match: :first)
    page.should have_content "Choose a category and start your quiz!"


    click_link 'Start new Quiz'
    page.should have_content "Quiz-Round IT"

    choose('select_question_3')
    click_link 'Check Answer'
    click_link 'Next Questions'
    page.should have_content "No more questions"
    click_link 'Back'
  end
end