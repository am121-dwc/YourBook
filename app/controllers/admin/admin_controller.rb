class Admin::AdminController < ApplicationController
  before_action :authenticate_admin!
  def top
  end

  def comments
    @comments = BookComment.all
    @books = Book.all
  end

  def users
    @users = User.all
  end

  def books
    @books = Book.all
  end

  def tags
    @tags = Tag.all
  end
end
