class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :set_questions_and_categories, only: [:edit, :index, :new, :show]

  def index
    #respond_with(@categories)
  end

  def show
    #respond_with(@category)
  end

  def new
    @category = Category.new
    #respond_with(@category)
  end

  def edit
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        addQuestions
        addUser
        format.html { redirect_to categories_url, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
    #respond_with(@category)
  end

  def update
    respond_to do |format|

      # do it simple remove first all relations between this category and the questions
      removeQuestions
      addQuestions

      if @category.update(category_params)
        format.html { redirect_to categories_url, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
    #respond_with(@category)
  end

  def destroy
    flag = false

    removeQuestions
    removeUsers

    Category.all.each do |category|
      if category.parent_id == @category.id
        flag = true
      end
    end

    if !flag
      @category.destroy
      respond_to do |format|
        format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      flash[:warning] = 'Category can not destroyed because it is a parent category.'
      redirect_to categories_url

    end

    #respond_with(@category)
  end

  def removeQuestions
    @category.category_to_questions.destroy_all
  end

  #todo what happen if save not possible?
  def addQuestions
    questions = params[:category][:questions]

    questions.each do |id|
      if id != ""
        CategoryToQuestion.new({'category_id' => @category.id, 'question_id' => id}).save
      end
    end
  end

  def addUser
    UserToCategory.new({'category_id' => @category.id, 'user_id' => current_user.id}).save
  end

  def removeUsers
    @category.user_to_categories.destroy_all
  end

  private
  def set_category
    @category = Category.find(params[:id])
  end

  #TODO Dry between this and questions_controller
  def set_questions_and_categories
    @questions = Question.all.where(:id => UserToQuestion.all.where(:user_id => current_user.id).map(&:question_id))
    @categories = Category.all.where(:id => UserToCategory.all.where(:user_id => current_user.id).map(&:category_id))
  end

  def category_params
    params.require(:category).permit(:name, :parent_id)
  end
end
