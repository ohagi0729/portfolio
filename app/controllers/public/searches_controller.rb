class Public::SearchesController < ApplicationController
  def search
    @range = params[:range]
    if @range == "Customer"
      @customers = Customer.where(is_active: true).looks(params[:search], params[:word])
    else
      @posts = Post.joins(:customer).where(customer: {is_active: true }).looks(params[:search], params[:word])
    end
  end
end