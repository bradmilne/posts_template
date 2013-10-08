class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
  	@post = Post.new
    @categories = Category.all
  end

  def create
  	@post = Post.new(post_params)
    @post_category = @post.post_categories.build(post_params)
    binding.pry
    if @post.save
      flash[:notice] = "Your post was saved."
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:notice] = "Your post was edited."
      redirect_to post_path(@post)
    else
      render :edit
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def post_params
    params.require(:post).permit(:title, :url, :description, post_categories_attributes: [:post_id, :category_id])
  end

  def post_category_params
    params.require(:category).merge(:category_id, post_id: @post.id)
  end 
end
