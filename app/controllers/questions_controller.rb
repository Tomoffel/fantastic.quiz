class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :set_category_ids, only: [:new, :show]
  before_action :set_questions_and_categories, only: [:edit, :index, :new, :show, :create]

  def index
    if (params[:cats] != nil)
      @ownCategories = Array.new
      params[:cats].each do |cat_id|
        @ownCategories.push(Category.find(cat_id))
        @question_id = params[:quest]
      end
    end

    #respond_with(@questions)
  end

  def show
    if !(current_user.has_role?(@question.id.to_s + "_see") || current_user.has_role?(@question.id.to_s) || current_user.has_role?(:admin))
      flash[:warning] = 'Permission denied'
      redirect_to questions_url
    end
  end

  def new
    @question = Question.new

    if(params[:question_text] != nil)
      setOldValues
    else
      # add default selected answer
      @correctValue1 = true
    end
    #respond_with(@question)
  end

  def edit
    if !( current_user.has_role?(@question.id.to_s) || current_user.has_role?(:admin))
      flash[:warning] = 'Permission denied'
      redirect_to questions_url
    end

    if(params[:question_text] != nil)
      setOldValues
    else
      @answerValue1 = @question.answers[0].answer
      @correctValue1 = @question.answers[0].correctAnswer
      @answerValue2 = @question.answers[1].answer
      @correctValue2 = @question.answers[1].correctAnswer
      @answerValue3 = @question.answers[2] == nil ? nil : @question.answers[2].answer
      @correctValue3 = @question.answers[2] == nil ? false : @question.answers[2].correctAnswer
      @answerValue4 = @question.answers[3] == nil ? nil : @question.answers[3].answer
      @correctValue4 = @question.answers[3] == nil ? false : @question.answers[3].correctAnswer

      @question_text = @question.question
    end
  end

  def setOldValues
    @question_text = params[:question_text]
    @answerValue1 = params[:answer1]
    @answerValue2 = params[:answer2]
    @answerValue3 = params[:answer3]
    @answerValue4 = params[:answer4]

    @correctValue1 = params[:selected] == "correct1"
    @correctValue2 = params[:selected] == "correct2"
    @correctValue3 = params[:selected] == "correct3"
    @correctValue4 = params[:selected] == "correct4"
  end


  def create
    setVariables

    if check_guilty_answers

      @question = Question.new(question_params)

      if @question.save
        addCategories

        current_user.add_role(@question.id)

        if create_new_answer(@answerValue1, @question.id, @correctValue1) and create_new_answer(@answerValue2, @question.id, @correctValue2) and (create_new_answer(@answerValue3, @question.id, @correctValue3) or @answerValue3 == "") and (create_new_answer(@answerValue4, @question.id, @correctValue4) or @answerValue4 == "")
          respond_to do |format|
            if params[:commit] == "Save"
              format.html { redirect_to questions_url, notice: 'Question successfully created!'}
              format.json { render :show, status: :created, location: @question }
            else
              format.html { redirect_to new_question_path(:cats=>params[:question][:id]), notice: 'Question successfully created!' }
              format.json { render :show, status: :created, location: @question }
            end

          end
        else
          @question.destroy
          flash[:warning] = 'Not enough answers.'
          redirect_to new_question_url(:question_text=>question_params[:question], :answer1=>@answerValue1, :answer2=>@answerValue2, :answer3=>@answerValue3, :answer4=>@answerValue4, :selected=>params[:question][:correctMethod])
        end
      else
        respond_to do |format|
          format.html { render :new }
          format.json { render json: @question.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:warning] = 'Not enough or no correct answer.'
      redirect_to new_question_url(:question_text=>question_params[:question], :answer1=>@answerValue1, :answer2=>@answerValue2, :answer3=>@answerValue3, :answer4=>@answerValue4, :selected=>params[:question][:correctMethod])
    end

    # respond_with(@question)
  end

  def create_new_answer(answer, questionId, correct)
    newAnswer = {'answer' => answer, 'question_id' => questionId, 'correctAnswer' => correct}
    return Answer.new(newAnswer).save
  end

  def check_guilty_answers()
    return (@answerValue1 != "" and @answerValue2 != "" and (@correctValue1 or @correctValue2 or (@answerValue3 != "" and @correctValue3) or (@answerValue4 != "" and @correctValue4)))
  end

  def update
    if !(current_user.has_role?(@question.id.to_s) || current_user.has_role?(:admin))
      flash[:warning] = 'Permission denied'
      redirect_to questions_url
    end

    setVariables

    if (check_guilty_answers)
      answer_params = {1 => {'answer' => @answerValue1, 'correctAnswer' => @correctValue1},
                       2 => {'answer' => @answerValue2, 'correctAnswer' => @correctValue2},
                       3 => {'answer' => @answerValue3, 'correctAnswer' => @correctValue3},
                       4 => {'answer' => @answerValue4, 'correctAnswer' => @correctValue4}}

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
      if (index == 3 and answer_params[3]['answer'] != "")
        noError = noError ? create_new_answer(answer_params[3]['answer'], @question.id, answer_params[3]['correctAnswer']) : false
        index = index + 1
      end

      if (index == 4 and  answer_params[4]['answer'] != "")
        noError = noError ? create_new_answer(answer_params[4]['answer'], @question.id, answer_params[4]['correctAnswer']) : false
      end

      removeCategories
      addCategories

      # respond_to do |format|
        if @question.update(question_params)
          if noError
            flash[:notice] = 'Question successfully updated!'
            if params[:commit] == "Save"
              redirect_to edit_question_url
            else
              redirect_to new_question_path(:cats=>params[:question][:id])
            end
          else
            flash[:warning] = 'Not enough or no correct answer.'
            redirect_to edit_question_url(:question_text=>question_params[:question], :answer1=>@answerValue1, :answer2=>@answerValue2, :answer3=>@answerValue3, :answer4=>@answerValue4, :selected=>params[:question][:correctMethod])
          end
        else
          flash[:notice] = 'No question text!'
          redirect_to edit_question_url(:question_text=>question_params[:question], :answer1=>@answerValue1, :answer2=>@answerValue2, :answer3=>@answerValue3, :answer4=>@answerValue4, :selected=>params[:question][:correctMethod])
        end
    else
      flash[:warning] = 'Not enough or no correct answer.'
      redirect_to edit_question_url(:question_text=>question_params[:question], :answer1=>@answerValue1, :answer2=>@answerValue2, :answer3=>@answerValue3, :answer4=>@answerValue4, :selected=>params[:question][:correctMethod])
    end

    #respond_with(@question)
  end

  def destroy
    if !(current_user.has_role?(@question.id.to_s) || current_user.has_role?(:admin))
      flash[:warning] = 'Permission denied'
      redirect_to questions_url
    end

    ownCategories = Array.new

    @question.categories.each do |cat|
      if current_user.has_role?(cat.name) || current_user.has_role?(:admin)
        ownCategories.push(cat)
      end
    end

    if ownCategories.length == 0
      flash[:warning] = 'Permission denied, you are not the owner of the categories'
      redirect_to questions_url
    else
      if ownCategories.length == 1
        removeCategories

        @question.answers.each do |ans|
          ans.destroy
        end

        Role.destroy_all(:name => @question.id)
        Role.destroy_all(:name => @question.id.to_s + "_see")

        @question.destroy

        respond_to do |format|
          format.html { redirect_to questions_url, notice: 'Question successfully deleted!' }
          format.json { head :no_content }
        end
      else
        redirect_to questions_url(:cats => ownCategories, :quest => @question.id)
      end
    end
  end

  def setVariables()
    @answerValue1 = params[:question][:answers1]
    @correctValue1 = params[:question][:correctMethod] == "correct1"
    @answerValue2 = params[:question][:answers2]
    @correctValue2 = params[:question][:correctMethod] == "correct2"
    @answerValue3 = params[:question][:answers3]
    @correctValue3 = params[:question][:correctMethod] == "correct3"
    @answerValue4 = params[:question][:answers4]
    @correctValue4 = params[:question][:correctMethod] == "correct4"
  end

  def removeCategories
    @question.category_to_questions.destroy_all
  end

  def addCategories
    params[:question][:id].each do |id|
      if id != ""
        CategoryToQuestion.new({'category_id' => id, 'question_id' => @question.id}).save
      end
    end
  end

  def delete_connection
    if !(current_user.has_role?(params[:quest]) || current_user.has_role?(:admin))
      flash[:warning] = 'Permission denied'
      redirect_to questions_url
    end

    CategoryToQuestion.where( :category_id =>params[:cat].to_i, :question_id => params[:quest].to_i).first.destroy

    redirect_to questions_url, notice: 'Connection between category and question successfully deleted!'
  end

  private
  def set_question
    @question = Question.find(params[:id])
    @categories_ids = Array.new

    @question.categories.all.each do |cat|
      @categories_ids.push(cat.id)
    end

  end

  def set_category_ids
    if params[:cats] != nil
      @categories_ids = params[:cats]
    end

    if params[:category_id] != nil
      if @categories_ids == nil
        @categories_ids = Array.new
      end
      @categories_ids.push(params[:category_id])
    end
  end

  def question_params
    params.require(:question).permit(:question)
  end

  def set_questions_and_categories
    @questions = check_question_role(Question)
    @categories = check_category_role(Category)
  end
end
