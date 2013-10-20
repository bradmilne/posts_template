class CategoriesController < ApplicationController

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
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    if @category.update(post_params)
      flash[:notice] = "Your category was edited."
      redirect_to category_path(@category)
    else
      render :edit
    end
  end


  def show
    @category = Category.find(params[:id])
  end

  def post_params
    params.require(:category).permit(:name)
  end


end
