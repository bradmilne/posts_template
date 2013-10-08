class CommentsController < ApplicationController


  def create
  	@post = Post.find(params[:post_id])
  	@comment = Comment.new(comment_params)

  	if @comment.save
  	  flash[:notice] = "Comment saved"
  	  redirect_to post_path(@post)
  	else
  		render 'posts/show'
  	end
  end


  def comment_params
  	params.require(:comment).permit(:body).merge(post_id: @post.id)
  end
end
