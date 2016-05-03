class PostsController < ApplicationController
before_action :authenticate_user!, except: [:index, :show]
before_action :set_post, only: [:show, :edit, :destroy, :update]

	def index
		@posts = Post.all
	end

	def new
		@post = Post.new
	end

	def edit
	end

	def update
		if @post.update(post_params)
			flash[:success] = "Post successfully updated"
			redirect_to posts_path
		else
			flash.now[:alert] = "Something is wrong with your form" #flash.now is for render
			render :edit
		end
	end

	def destroy
		@post.destroy
		flash.now[:success] = "Post deleted" #flash.now is for render
		redirect_to root_path
	end

	def create
		@post = current_user.posts.build(post_params)

		if @post.save
			flash[:success] = "Your post has been created"
			redirect_to posts_path
		else
			flash[:alert] = 'Halt, you fiend! You need an image to post here!'
			render :new
		end
	end

	def show
		@post = Post.find(params[:id])
	end

	private

	def post_params
		params.require(:post).permit(:caption, :image)
	end

	def set_post
		@post = Post.find(params[:id])
	end
end
