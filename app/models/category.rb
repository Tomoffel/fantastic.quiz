class Category < ActiveRecord::Base
  belongs_to :category
  has_many :category_to_questions
  has_many :questions, through: :category_to_questions

  has_many :user_to_categories
  has_many :users, through: :user_to_categories

  validates :name, presence: true
end
