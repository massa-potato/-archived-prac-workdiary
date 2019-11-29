class CategoriesController < ApplicationController
  def new
    @category = Category.new
    @diary_id = session[:diary_id] = params[:diary_id]
  end
  
  def create
    @category = Category.new(category_params)
    @diary_id = session[:diary_id]
    if @category.save
      if @diary_id.present?
        redirect_to new_diary_work_path(@diary_id)
        session[:diary_id] = nil
      else
        redirect_to categories_path
      end
    else 
      render 'new'
    end
  end
  
  def index
    @categories = Category.all
  end
  
  def edit
    @category = Category.find params[:id]
  end
  
  def update
    @category = Category.find params[:id]
    if @category.update(category_params)
      redirect_to categories_path
    else
      render 'edit'
    end
  end
  
  private
  
  def category_params
    params.require(:category).permit(:name)
  end  
  
end