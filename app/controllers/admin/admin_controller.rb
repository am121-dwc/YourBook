class Admin::AdminController < ApplicationController
  def top
  end

  def comments
    @comments = BookComment.all
    @books = Book.all
  end

  def users
    @users = User.all
  end
end