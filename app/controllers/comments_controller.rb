class CommentsController < ApplicationController
	before_action :set_post


	def new
		@comment = Comment.new
	end

	def create
		@comment = @post.comments.build(comment_params)
		@comment.user_id = current_user.id

		if @comment.save
			flash[:success] = "You have commented on this post"
			respond_to do |format|
				format.html { redirect_to root_path}
				format.js
			end
		else
			flash[:alert] = "Check the comment form, something went wrong!"
			render root_path
		end
	end

	def destroy
		@comment = @post.comments.find(params[:id])

		if @comment.user_id == current_user.id
			@comment.destroy
			flash[:success] = "comment deleted"
			respond_to do |format|
				format.html { redirect_to root_path }
				format.js
			end
		end
	end

	private

	def set_post
		@post = Post.find(params[:post_id])
	end

	def comment_params
		params.require(:comment).permit(:content)
	end
end
