# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

vwl = Category.create( name: 'VWL' )
bwl = Category.create( name: 'BWL')
it = Category.create( name: 'IT' )

rw = Category.create(name: 'Rechnungswesen', parent_id: bwl.id)
se = Category.create(name: 'Softwareentwicklung', parent_id: it.id)

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

CategoryToQuestion.create(question_id: question1.id, category_id: bwl.id)
CategoryToQuestion.create(question_id: question2.id, category_id: se.id)
CategoryToQuestion.create(question_id: question3.id, category_id: it.id)
CategoryToQuestion.create(question_id: question4.id, category_id: it.id)
CategoryToQuestion.create(question_id: question5.id, category_id: it.id)

adminUser = User.create(email: "admin@admin.de", password: 'adminadmin', password_confirmation: 'adminadmin')


UserToCategory.create(user_id: adminUser.id, category_id: vwl.id)
UserToCategory.create(user_id: adminUser.id, category_id: bwl.id)
UserToCategory.create(user_id: adminUser.id, category_id: it.id)
UserToCategory.create(user_id: adminUser.id, category_id: rw.id)
UserToCategory.create(user_id: adminUser.id, category_id: se.id)

UserToQuestion.create(question_id: question1.id, user_id: adminUser.id)
UserToQuestion.create(question_id: question2.id, user_id: adminUser.id)
UserToQuestion.create(question_id: question3.id, user_id: adminUser.id)
UserToQuestion.create(question_id: question4.id, user_id: adminUser.id)
UserToQuestion.create(question_id: question5.id, user_id: adminUser.id)
UserToQuestion.create(question_id: question6.id, user_id: adminUser.id)
UserToQuestion.create(question_id: question7.id, user_id: adminUser.id)

