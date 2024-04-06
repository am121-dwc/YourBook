class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:destroy]
  def edit
    @user = User.find(params[:id])
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to root_path
    end
  end
  def update
    @user = User.find(params[:id])
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to root_path
    end
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
    # 一週間での期間内いいね数による並び替え
    # to = Time.current.at_end_of_day
    # from = (to - 6.day).at_beginning_of_day
    # @books = Book.includes(:favorites).sort_by { |book| -book.favorites.where(created_at: from...to).count }
    # いいね順に並び替え
    @books = Book.includes(:favorites).sort_by { |book| -book.favorites.count }
    @new_books = Book.all.order(created_at: :desc)
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end