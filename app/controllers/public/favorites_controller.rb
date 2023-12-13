class Public::FavoritesController < ApplicationController
  before_action :active_customer, only:[:create,:destroy]

  def create
    @post = Post.find(params[:post_id])
    favorite = current_customer.favorites.new(post_id: @post.id)
    favorite.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_customer.favorites.find_by(post_id: @post.id)
    favorite.destroy
  end

  def active_customer
    if !Post.find(params[:post_id]).customer.is_active
      redirect_to public_posts_path
    end
  end
end
