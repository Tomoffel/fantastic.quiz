class Question < ActiveRecord::Base
  has_many :answers
  has_many :category_to_questions

  validates :question, presence: true
end
