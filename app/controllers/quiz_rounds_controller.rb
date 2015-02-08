class QuizRoundsController < ApplicationController
  before_action :authenticate_user!

  def index
    @category = Category.find(params[:category])

    if params[:question] != nil
      @question = Question.find(params[:question])
      @answerChoose = 1
      @selectedAnswer = params[:selectedAnswer]
    else
      @answerChoose = 0
      @selectedAnswer = 1

      #todo do it dry (questions/categories)
      @children = Category.where(:id => UserToCategory.where(:user_id => current_user.id)).where(:parent_id => @category.id)
      @questions = @category.questions

      #get questions from children
      @children.each do |child|
        @questions.push( child.questions )
      end

      @questions = @questions.where.not(:id => QuizRound.where("category_id" => @category.id, "user_id" => current_user.id).map(&:question).map(&:id))
      length = @questions.count

      if length == 0
      #all questions done
      else
        getNextQuestion(length)
      end
    end
  end

  def new
    categoryId = params[:category]
    QuizRound.where("category_id" => categoryId, "user_id" => current_user.id).destroy_all

    redirect_to quiz_round_url(:category=> categoryId)
  end

  def getNextQuestion(length)
    randNumber = rand(length)
    count = 0
    @questions.each do |quest|
      if count == randNumber
        @question = quest
      end
      count = count + 1
    end
  end

  def check
    categoryId = params[:category]
    questionId = params[:question]

    question = Question.find(params[:question])

    correct = false
    index = 1
    question.answers.each do |ans|
      if index == params[:selectedAnswer].to_i && ans.correctAnswer
        correct = true
      end
      index = index + 1
    end

    QuizRound.create("category_id" => categoryId, "question_id" => questionId, "user_id" => current_user.id, "correct" => correct)

    redirect_to quiz_round_url(:category=> categoryId, :question=>questionId, :selectedAnswer => params[:selectedAnswer])
  end

end