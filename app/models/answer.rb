class Answer < ActiveRecord::Base
  has_one :question
  validates :answer, :question_id, presence: true
end
