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
 
    if @post.save
      binding.pry

      params[:post][:category_ids].each do |f|
        PostCategory.create(post_id: @post.id, category_id: f)
      end
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
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

end
