class Public::CustomersController < ApplicationController
  before_action :ensure_correct_customer, only: [:edit, :update, :confirm, :unsubscribe]
  before_action :ensure_guest_customer, only: [:edit]
  before_action :active_customer, only:[:show,:edit,:update,:followings,:followers,:favorites]

  def index
    @customers = Customer.where(is_active:true)
    @post = Post.new
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
    @post = Post.new
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      flash[:notice] = "プロフィールが更新されたニャン(`ФωФ’)✧"
      redirect_to public_customer_path(@customer)
    else
      flash.now[:notice] = "プロフィールの更新に失敗したニャンΣ(ФωФ=ﾉ)ﾉ"
      render "edit"
    end
  end

  def followings
    @customer = Customer.find(params[:id])
    @customers = @customer.following_customers
  end

  def followers
    @customer = Customer.find(params[:id])
    @customers = @customer.follower_customers
  end

  def favorites
    @customer = Customer.find(params[:id])
    favorited_post_id = Favorite.where(customer_id: @customer.id).pluck(:post_id)
    @favorite_posts = Post.joins(:customer).where(customer: { is_active: true}, id: favorited_post_id)
  end

  def confirm
    @customer = current_customer
  end

  def unsubscribe
    @customer = current_customer
    @customer.update(is_active: false)
    # byebug
    reset_session
    flash.now[:notice] = "退会処理をしたニャン(´ΦωΦ`)"
    redirect_to root_path
  end

  def confirm
  end

private

  def customer_params
    params.require(:customer).permit(:name, :profile_image, :introduction)
  end

  def ensure_correct_customer
  @customer = Customer.find_by(id: params[:id])
    if @customer.nil?
      flash.now[:notice] = "ユーザーが見つからないニャン(´ΦωΦ`)"
      redirect_to root_path
    elsif current_customer != @customer
      flash.now[:notice] = "権限がないニャン(´ΦωΦ`)"
      redirect_to root_path
    end
  end

  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.guest_customer?
      redirect_to customer_path(current_customer)
    end
  end

protected
  def active_customer
    if !Customer.find(params[:id]).is_active
      redirect_to public_customers_path
    end
  end

  # 会員の論理削除のための記述。退会後は、同じアカウントでは利用できない。
  def reject_customer
    @customer = Customer.find_by(email: params[:customer][:email])
    if @customer
      if @customer.valid_password?(params[:customer][:password]) && (@customer.is_deleted == false)
        flash.now[:notice] = "退会済みニャン　再度登録してニャン(´ΦωΦ`)"
        redirect_to new_customer_registration
      else
        flash.now[:notice] = "項目を入力してニャン(´ΦωΦ`)"
      end
    end
  end
end
