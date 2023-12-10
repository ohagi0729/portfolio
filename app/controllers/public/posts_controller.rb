class Public::PostsController < ApplicationController
  before_action :authenticate_customer!, only: [:create]
  before_action :ensure_correct_customer, only: [:edit, :update]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      redirect_to public_posts_path
    else
      render :new
    end
  end

  def index
    @posts = Post.all
    @customers = Customer.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def customer_params
    params.require(:customer).permit(:name, :profile_image, :introduction)
  end

end