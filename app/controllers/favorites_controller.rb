class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save
  end

  def destroy
    @book = Book.find(params[:book_id])
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
  end
  def create_book_comment
    @comment = BookComment.find(params[:book_comment_id])
    @book = @comment.book
    favorite = current_user.favorites.new(book_id: @book.id, book_comment_id: @comment.id)
    favorite.save
    # 非同期化ができていないためhtmlでの処理です。
    redirect_to request.referer
  end

  def destroy_book_comment
    @comment = BookComment.find(params[:book_comment_id])
    @book = @comment.book
    favorite = current_user.favorites.find_by(book_id: @book.id, book_comment_id: @comment.id)
    favorite.destroy
    # 非同期化ができていないためhtmlでの処理です。
    redirect_to request.referer
  end
end
