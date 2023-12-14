class Public::RelationshipsController < ApplicationController
  before_action :authenticate_customer!
  before_action :active_customer, only:[:create,:destroy,:followings,:followers]

  def create
    @customer = Customer.find(params[:customer_id])
    current_customer.follow(@customer)
  end

  def destroy
    @customer = Customer.find(params[:customer_id])
    current_customer.unfollow(@customer)
  end

  def followings
    customer = Customer.find(params[:customer_id])
    @customer = customer.followings.where(is_active:true)
  end

  def followers
    customer = Customer.find(params[:customer_id])
    @customers = customer.followers.where(is_active:true)
  end

  def active_customer
    if !Customer.find(params[:customer_id]).is_active
      redirect_to public_customers_path
    end
  end
end
