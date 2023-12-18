class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_customer, only: [:show, :edit, :update]

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    if @customer.update(customer_params)
      flash[:notice] = "プロフィールが更新されたニャ(=ↀωↀ=)✧"
      redirect_to admin_customer_path(@customer)
    else
      flash[:notice] = "ユーザーネームは必須ニャ(=ↀωↀ=)"
      render "edit"
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name,:email,:is_active,:introduction,:profile_image)
  end

  def ensure_customer
    @customer = Customer.find(params[:id])
  end
end
