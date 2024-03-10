class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "Book was updated."
    else
      flash.now[:notice] = "Book was not updated."
      reuest.referer
    end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "Book was created."
    else
      flash.now[:notice] = "Book was not created."
      @books = Book.all
      render 'index'
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :introduction)
  end
end
