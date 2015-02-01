class CategoryToQuestion < ActiveRecord::Base
  belongs_to :category
  belongs_to :question

  validates :category_id, :question_id, presence: true
end
