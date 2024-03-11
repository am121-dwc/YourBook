class UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "Your profile has been updated."
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end
  def my_page
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
