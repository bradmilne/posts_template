class CategoriesController < ApplicationController


  before_action :set_category, only: [:show, :edit, :update] 
  before_action :require_user, except: [:index, :show]
  before_action :require_admin, only: [:create]

  def index
    @categories = Category.all
  end

  def new
  	@category = Category.new
  end

  def create
  	@category = Category.new(post_params)

    if @category.save
      flash[:notice] = "Your category was saved."
      redirect_to categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update

    if @category.update(post_params)
      flash[:notice] = "Your category was edited."
      redirect_to category_path(@category)
    else
      render :edit
    end
  end


  def show
  end

  def post_params
    params.require(:category).permit(:name)
  end

  private

  def set_category
    @category = Category.find_by(slug: params[:id])  
  end  


end
