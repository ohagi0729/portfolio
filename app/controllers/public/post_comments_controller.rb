class Public::PostCommentsController < ApplicationController

   def create
      post = Post.find(params[:post_id])
      if !post.customer.is_active
         redirect_to public_post_path
      end
     @post_comments = post.post_comments.joins(:customer).where(customer: {is_active: true })
     @comment = current_customer.post_comments.new(post_comment_params)
     @comment.post_id = post.id
     @comment.save
   end

   def destroy
      post_comment = PostComment.find(params[:id])
      if !post_comment.post.customer.is_active
         redirect_to public_post_path
      end
      @post_comments = post_comment.post.post_comments.joins(:customer).where(customer: {is_active: true })
      @comment = post_comment.destroy
   end

   private

   def post_comment_params
     params.require(:post_comment).permit(:comment)
   end
end