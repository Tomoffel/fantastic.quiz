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

Category.create(name: 'Rechnungswesen', parent_id: bwl.id)
Category.create(name: 'Softwareentwicklung', parent_id: it.id)

question = Question.create(question: 'Was ist nicht Bestandteil des Umlaufvermögens?')
Answer.create(answer: 'Roh - Hilfs - und Betriebsstoffe', question_id: question.id)
Answer.create(answer: 'Gewinnrücklagen', question_id: question.id, correctAnswer: 't')

question = Question.create(question: 'Was ist final int MAX_CIRCLES = 100 für ein Variablentyp?')
Answer.create(answer: 'Konstante', question_id: question.id, correctAnswer: 't')
Answer.create(answer: 'Klassenvariable', question_id: question.id)
Answer.create(answer: 'Parameter', question_id: question.id)

question = Question.create(question: 'Wie nennt man die Anpassung bzw. Aktualisierung von Software-Versionen?')
Answer.create(answer: 'Backup', question_id: question.id)
Answer.create(answer: 'Ripping', question_id: question.id)
Answer.create(answer: 'Update', question_id: question.id, correctAnswer: 't')

question = Question.create(question: 'Was gehört nicht zur Hardware?')
Answer.create(answer: 'Maus', question_id: question.id)
Answer.create(answer: 'RAM-Speicher', question_id: question.id)
Answer.create(answer: 'Harddiskdriver', question_id: question.id, correctAnswer: 't')

question = Question.create(question: 'Ein eigens für ein Unternehmen oder eine Gruppe aufgestelltes Netzwerk mit Internet-Technologie nennt sich?')
Answer.create(answer: 'Telnet', question_id: question.id)
Answer.create(answer: 'WAN', question_id: question.id)
Answer.create(answer: 'Intranet', question_id: question.id, correctAnswer: 't')
Answer.create(answer: 'Chat', question_id: question.id)

question = Question.create(question: 'Wie wird die Summe aller Sachgüter und Dienstleistungen, die in einer Volkswirtschaft im Laufe eines Jahres geschaffen werden, bezeichnet?')
Answer.create(answer: 'Bruttosozialprodukt', question_id: question.id, correctAnswer: 't')
Answer.create(answer: 'Lebensstandard', question_id: question.id)
Answer.create(answer: 'Volksvermögen', question_id: question.id)
Answer.create(answer: 'Gesamtbedarf', question_id: question.id)

question = Question.create(question: 'Was ist keine Individualversicherung?')
Answer.create(answer: 'private Krankenversicherung', question_id: question.id)
Answer.create(answer: 'Lebensversicherung', question_id: question.id)
Answer.create(answer: 'Kfz-Versicherung', question_id: question.id)
Answer.create(answer: 'betriebliche Unfallversicherung', question_id: question.id, correctAnswer: 't')

