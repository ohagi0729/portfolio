class Public::PostsController < ApplicationController
  before_action :authenticate_customer!, only: [:create]
  before_action :ensure_correct_customer, only: [:edit, :update]
  before_action :active_customer, only:[:show,:update]

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
    @posts = Post.where(customer_id:Customer.where(is_active:true).pluck(:id))
    @customers = Customer.where(is_active:true)
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.joins(:customer).where(customer: {is_active: true })
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to public_posts_path
  end

  private
  def active_customer
    if !Post.find(params[:id]).customer.is_active
      redirect_to public_posts_path
    end
  end

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def customer_params
    params.require(:customer).permit(:name, :profile_image, :introduction)
  end

end