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
    # add default selected answer
    @correctValue1 = true
    #respond_with(@question)
  end

  def edit
    @answerValue1 = @question.answers[0].answer
    @correctValue1 = @question.answers[0].correctAnswer
    @answerValue2 = @question.answers[1].answer
    @correctValue2 = @question.answers[1].correctAnswer
    @answerValue3 = @question.answers[2] == nil ? nil : @question.answers[2].answer
    @correctValue3 = @question.answers[2] == nil ? false : @question.answers[2].correctAnswer
    @answerValue4 = @question.answers[3] == nil ? nil : @question.answers[3].answer
    @correctValue4 = @question.answers[3] == nil ? false : @question.answers[3].correctAnswer
  end

  def create
    # todo errors save values
    if check_guilty_answers

      @question = Question.new(question_params)

      if @question.save
        if create_new_answer(params['question']['answers1'], @question.id, params['question']['correctMethod'] == 'correct1') and create_new_answer(params['question']['answers2'], @question.id, params['question']['correctMethod'] == 'correct2') and (create_new_answer(params['question']['answers3'], @question.id, params['question']['correctMethod'] == 'correct3') or params['question']['answers3'] == "") and (create_new_answer(params['question']['answers4'], @question.id, params['question']['correctMethod'] == 'correct4') or params['question']['answers4'] == "")
          respond_to do |format|
            format.html { redirect_to questions_url, notice: 'Question successfully created!' }
            format.json { render :show, status: :created, location: @question }
          end
        else
          @question.destroy
          flash[:warning] = 'Not enough answers.'
          redirect_to new_question_url
        end
      else
        respond_to do |format|
          format.html { render :new }
          format.json { render json: @question.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:warning] = 'Not enough or no correct answer.'
      redirect_to new_question_url
    end

    # respond_with(@question)
  end

  def create_new_answer(answer, questionId, correct)
    newAnswer = {'answer' => answer, 'question_id' => questionId, 'correctAnswer' => correct}
    return Answer.new(newAnswer).save
  end

  def check_guilty_answers()
    return (params['question']['answers1'] != "" and params['question']['answers2'] != "" and (params['question']['correctMethod'] == 'correct1' or params['question']['correctMethod'] == 'correct2' or (params['question']['answers3'] != "" and params['question']['correctMethod'] == 'correct3') or (params['question']['answers3'] != "" and params['question']['correctMethod'] == 'correct3')))
  end

  def update
    if (check_guilty_answers)
      answer_params = {1 => {'answer' => params['question']['answers1'], 'correctAnswer' => params['question']['correctMethod'] == 'correct1'},
                       2 => {'answer' => params['question']['answers2'], 'correctAnswer' => params['question']['correctMethod'] == 'correct2'},
                       3 => {'answer' => params['question']['answers3'], 'correctAnswer' => params['question']['correctMethod'] == 'correct3'},
                       4 => {'answer' => params['question']['answers4'], 'correctAnswer' => params['question']['correctMethod'] == 'correct4'}}

      noError = true

      index = 1
      @question.answers.each do |ans|
        if (answer_params[index]['answer'] == "" and index > 2)
          noError = noError ? ans.delete : false
        else
          if (answer_params[index]['answer'] == "" and index <= 2)
            noError = false
          else
            #TODO do it nice
            ans.delete
            noError = noError ? create_new_answer(answer_params[index]['answer'], @question.id, answer_params[index]['correctAnswer']) : false
          end
        end
        index = index + 1
      end

      #maybe add new answers
      if (index == 3 and answer_params[3]['answer'] != nil)
        noError = noError ? create_new_answer(answer_params[3]['answer'], @question.id, answer_params[3]['correctAnswer']) : false
        index = index + 1
      end

      if (index == 4 and  answer_params[4]['answer'] != nil)
        noError = noError ? create_new_answer(answer_params[4]['answer'], @question.id, answer_params[4]['correctAnswer']) : false
      end

      # respond_to do |format|
        if @question.update(question_params)
          if noError
            flash[:notice] = 'Question successfully updated!'
            redirect_to edit_question_url
            # format.html { redirect_to questions_url, notice: 'Question successfully updated!' }
            # format.json { render :show, status: :ok, location: @question }
          else
            flash[:warning] = 'Not enough or no correct answer.'
            redirect_to edit_question_url
          end
        else
          flash[:notice] = 'No question text!'
          redirect_to edit_question_url
          # format.html { render :edit }
          # format.json { render json: @question.errors, status: :unprocessable_entity }
        end
    else
      flash[:warning] = 'Not enough or no correct answer.'
      redirect_to edit_question_url
    end

    #respond_with(@question)
  end

  def destroy
    @question.answers.each do |ans|
      ans.destroy
    end

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
