class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
  	@post = Post.new
  end

  def create
  	post = Post.new(title: params[:title], url: params[:url], user_id: 1)
    binding.pry

    if post.save
      flash[:notice] = "Your post was saved."
      redirect_to posts_path
    else
  
    end
  end

  def edit
  end

  def update
  end
  
  def show
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:title).permit(:url, :description)
  end


end
