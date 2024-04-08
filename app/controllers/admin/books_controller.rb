class Admin::BooksController < ApplicationController
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to admin_books_path
  end
end
