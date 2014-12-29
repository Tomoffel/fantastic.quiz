class Answer < ActiveRecord::Base
  has_one :questions, through: :question_answers

  validates :answer, presence: true
end
