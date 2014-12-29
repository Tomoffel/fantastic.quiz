class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
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
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category}
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
    #respond_with(@category)
  end

  def update

    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
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

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :parent_id)
    end
end
