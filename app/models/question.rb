class Question < ActiveRecord::Base
  has_many :answers

  validates :question, presence: true
end
