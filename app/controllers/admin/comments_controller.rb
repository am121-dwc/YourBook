class Admin::CommentsController < ApplicationController
  def destroy
    comment = BookComment.find(params[:id])
    comment.destroy
  end
end
