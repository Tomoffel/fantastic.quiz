class Answer < ActiveRecord::Base
  has_one :question
  validates :answer, :question_id, presence: true
#   TODO default value of correctAnswer = false
end
