class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :set_questions_and_categories, only: [:index, :show, :create]
  before_action :set_questions_and_categories_only_full_access, only: [:new, :edit, :update]
  before_action :set_role_user, only: [:edit, :show, :new, :update, :create]

  def index
    #respond_with(@categories)
  end

  def show
    if !(current_user.has_role?(@category.name + "_see") ||current_user.has_role?(@category.name + "_full") || current_user.has_role?(@category.name) || current_user.has_role?(:admin))
      flash[:warning] = 'Permission denied'
      redirect_to categories_url
    end
  end

  def new
    @category = Category.new
    #respond_with(@category)
  end

  def edit
    if !(current_user.has_role?(@category.name + "_full") || current_user.has_role?(@category.name) || current_user.has_role?(:admin))
      flash[:warning] = 'Permission denied'
      redirect_to categories_url
    end
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        addQuestions
        create_roles

        current_user.add_role(@category.name + @category.id.to_s)

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
    if !(current_user.has_role?(@category.name + @category.id.to_s + "_full") || current_user.has_role?(@category.name + @category.id.to_s) || current_user.has_role?(:admin))
      flash[:warning] = 'Permission denied'
      redirect_to categories_url
    end

    respond_to do |format|

      # do it simple remove first all relations between this category and the questions
      removeQuestions
      addQuestions

      if @category.update(category_params)
        create_roles

        format.html { redirect_to categories_url, notice: 'Category was successfully updated.'}
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
    #respond_with(@category)
  end

  def destroy_questions_roles
    @category.questions.each do |quest|
      Role.destroy_all(:name => quest.id.to_s + "_see")
      Role.destroy_all(:name => quest.id.to_s + "_full")
    end
  end

  def create_roles()
    Role.destroy_all(:name => @category.name  + @category.id.to_s + "_see")
    Role.destroy_all(:name => @category.name  + @category.id.to_s + "_full")

    destroy_questions_roles

    usersWithFullAccess = params[:list_with_full_access][:id]
    usersWithAccessToShow = params[:list_with_access_to_show][:id]

    @category.questions.each do |quest|
      set_roles(usersWithFullAccess, quest.id.to_s)
      set_roles(usersWithAccessToShow, quest.id.to_s + "_see")

      @owner.add_role(quest.id.to_s)
    end

    set_roles( usersWithFullAccess, @category.name + @category.id.to_s + "_full" )
    set_roles( usersWithAccessToShow, @category.name + @category.id.to_s + "_see" )
  end

  def set_roles(list, typ)
    if list != nil
      list.each do |id|
        if id != ""
          User.find(id.to_i).add_role(typ)
        end
      end
    end
  end

  def destroy
    if !(current_user.has_role?(@category.name + @category.id.to_s) || current_user.has_role?(:admin))
      flash[:warning] = 'Permission denied'
      redirect_to categories_url
    end

    flag = false

    Category.all.each do |category|
      if category.parent_id == @category.id
        flag = true
      end
    end

    if !flag
      removeQuestions

      Role.destroy_all(:name => @category.name + @category.id.to_s)
      Role.destroy_all(:name => @category.name + @category.id.to_s + "_see")
      Role.destroy_all(:name => @category.name + @category.id.to_s + "_full")

      destroy_questions_roles

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

  private
  def set_category
    @category = Category.find(params[:id])
  end

  def set_questions_and_categories
    @questions = check_question_role(Question)
    @categories = check_category_role(Category)
  end

  def category_params
    params.require(:category).permit(:name, :parent_id)
  end

  def set_role_user
    @usersWithoutRole = Array.new

    User.all.each do |user|
      @usersWithoutRole.push( user )
    end


    if(@category != nil)
      @usersWithFullAccess = User.with_role (@category.name + @category.id.to_s + "_full")
      @usersWithSeeAccess = User.with_role (@category.name + @category.id.to_s + "_see")

      @usersWithFullAccess.each do |rem|
        @usersWithoutRole.delete(rem)
      end

      @usersWithSeeAccess.each do |rem|
        @usersWithoutRole.delete(rem)
      end

      @owner = User.with_role(@category.name + @category.id.to_s).first
    else
      @usersWithFullAccess = Array.new
      @usersWithSeeAccess = Array.new
      @owner = current_user
    end

    @usersWithoutRole.delete(@owner)

  end

  def set_questions_and_categories_only_full_access
    @questions = check_question_role_only_full_access(Question)
    @categories = check_category_role_only_full_access(Category)

    if (@category != nil)
      parent_id = @category.parent_id
      if parent_id != nil
        parent = Category.find(parent_id)
        if !(current_user.has_role?(parent.name + parent.id.to_s) || current_user.has_role?(parent.name + parent.id.to_s + "_full") || current_user.has_role?(parent.name + parent.id.to_s + "_see"))
          @categories.push(parent)
        end
      end

      @categories.delete(@category)
    end


  end
end
