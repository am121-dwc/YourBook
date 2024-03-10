class Admin::CommentsController < ApplicationController
  def index
    @comments = BookComment.all
  end

  def destroy
    @book = Book.find(params[:book_id])
    comment = BookComment.find(params[:id])
    comment.destroy
  end
end
