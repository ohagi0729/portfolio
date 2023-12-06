class Public::PostsController < ApplicationController
  before_action :authenticate_customer!, only: [:create]

  def new
    @post = Post.new
  end

  # 投稿データの保存
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
  end

  def show
    @post = Post.find(params[:id])
    @post = PostComment.new
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  # 投稿データのストロングパラメータ
  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end
end