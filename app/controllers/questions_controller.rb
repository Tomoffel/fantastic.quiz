class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all
    #respond_with(@questions)
  end

  def show
    #respond_with(@question)
  end

  def new
    @question = Question.new
    #respond_with(@question)
  end

  def edit
  end

  def create
    @question = Question.new(question_params)

    newAnswer = { 'answer' => question_params['answer1'], 'question_id' => @question.id, 'correctAnswer' => false }

    if Answer.new(newAnswer).save

    else
    end
    # Answer.new(question_params['answer2']).save
    # Answer.new(question_params['answer3']).save
    # Answer.new(question_params['answer4']).save

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question successfully created!' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
   # respond_with(@question)
  end

  def update
    @question.update(question_params)
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question successfully updated!' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
    #respond_with(@question)
  end

  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question successfully deleted!' }
      format.json { head :no_content }
    end
    #respond_with(@question)
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:question)
    end
end
