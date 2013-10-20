class CommentsController < ApplicationController

before_action :require_user

  def create
  	@post = Post.find(params[:post_id])
  	@comment = @post.comments.new(comment_params)
  	@comment.creator = current_user
  	if @comment.save
  		flash[:notice] = "Your comment was created"
  		redirect_to post_path(@post)
  	else
  		render 'posts/show'
  	end
  end

  def comment_params
  	params.require(:comment).permit(:body)
  end

  def vote
    post = Post.find_by(slug: params[:id])  
    comment = Comment.find(params[:id])
    Vote.create(voteable: comment, creator: current_user, vote: params[:vote])
      respond_to do |format|
        format.html { redirect_to :back, notice: "Your vote was counted" }
        format.js   {}
      end
  end

end
