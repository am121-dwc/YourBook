class UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_my_page_path, notice: "Your profile has been updated."
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
    @user = current_user
    @event = Event.new
    # いいね数による並び替え
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorites).sort_by { |book| -book.favorites.where(created_at: from...to).count }
  end
  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
