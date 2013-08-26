class CommentsController < ApplicationController
  def create
    comment = Comment.new(content: params[:comment][:content])
    comment.sender = current_user
    item = Item.find(params[:comment][:item_id])
    item.comments << comment
    redirect_to item_path(item)
    
  end
end
