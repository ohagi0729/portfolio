class Public::CustomersController < ApplicationController
  before_action :ensure_correct_customer, only: [:edit, :update]

  def index
    @customers = Customer.all
    @post = Post.new
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
    @post = Post.new
    #@following_customers = @customer.following_customers
    #@follower_customers = @customer.follower_customers
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to public_customer_path(@customer), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def confirm
  end

  def unsubscribe
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :profile_image, :introduction)
  end

  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    unless current_customer == @customer
      flash[:alert] = "権限がありません"
      redirect_to root_path
    end
  end
end
