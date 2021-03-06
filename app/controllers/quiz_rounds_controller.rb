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

      questions = getQuestions(@category)

      length = questions.count

      if length == 0
        #all questions done
      else
        @question = questions[rand(length)]
      end
    end
  end

  def getQuestions(category)
    children = check_category_role(Category).select {|parent| parent.parent_id == category.id}
    questions = category.questions

    #get questions from children
    children.each do |child|
      questions = questions + child.questions
    end

    answeredQuestion = Array.new

    QuizRound.where("category_id" => category.id, "user_id" => current_user.id).map(&:question).each do |rem|
      answeredQuestion.push(rem)
    end

    questions = questions - answeredQuestion

    return questions
  end

  def new
    categoryId = params[:category]
    QuizRound.where("category_id" => categoryId, "user_id" => current_user.id).destroy_all

    redirect_to quiz_round_url(:category=> categoryId)
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

  def falseRound
    categoryId = params[:category]
    questions = getQuestions(Category.find(categoryId))

    # set not answered questions as correct
    questions.each do |quest|
      QuizRound.create("category_id" => categoryId, "question_id" => quest.id, "user_id" => current_user.id, "correct" => true)
    end

    # remove all false questions
    QuizRound.where("category_id" => categoryId, "user_id" => current_user.id, "correct" => false).destroy_all

    redirect_to quiz_round_url(:category=> categoryId)
  end

  def show
    @categories = check_category_role(Category)
  end

end