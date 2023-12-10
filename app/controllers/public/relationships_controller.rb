class Public::RelationshipsController < ApplicationController
before_action :authenticate_customer!
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
    @customer = customer.followings
  end

  def followers
    customer = Customer.find(params[:customer_id])
    @customers = customer.followers
  end
end
