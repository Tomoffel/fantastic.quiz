class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  def index
    @answers = Answer.all
    #respond_with(@answers)
  end

  def show
    #respond_with(@answer)
  end

  def new
    @answer = Answer.new
    #respond_with(@answer)
  end

  def edit
  end

  def create
    @answer = Answer.new(answer_params)

    respond_to do |format|
      if @answer.save
        format.html { redirect_to @answer, notice: 'Answer successfully created!' }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { render :new }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
    # respond_with(@answer)
  end

  def update
    @answer.update(answer_params)
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @answer, notice: 'Answer successfully updated!' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @qanswer.errors, status: :unprocessable_entity }
      end
    end
    #respond_with(@answer)
  end

  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to answer_url, notice: 'Answer successfully deleted!' }
      format.json { head :no_content }
    end
    #respond_with(@answer)
  end

  private
  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:answer)
  end
end
