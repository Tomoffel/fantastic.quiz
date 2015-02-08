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
      @children = Category.all.where(:id => UserToCategory.all.where(:user_id => current_user.id)).where(:parent_id => @category.id)
      @questions = @category.questions

      #get questions from children
      @children.each do |child|
        @questions = @questions
      end
      # @questions = @questions.all.where('id not in (?)',QuizRound.all.where(:user_id => current_user.id, :category_id => @category.id).map(&:question_id))
      length = @questions.count

      if length == 0
      #all questions done
      else
        getNextQuestion(length)
      end
    end
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
    redirect_to quiz_round_url(:category=>params[:category], :question=>params[:question], :selectedAnswer => params[:selectedAnswer])
  end

end