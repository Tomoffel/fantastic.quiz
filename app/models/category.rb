class Category < ActiveRecord::Base
  belongs_to :category
  has_many :category_to_questions
  has_many :questions, through: :category_to_questions
  validates :name, presence: true
  validates_uniqueness_of :name
end
