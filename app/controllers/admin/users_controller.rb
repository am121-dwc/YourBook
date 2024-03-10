class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end
  def destroy
    user = user.find(params[:id])
    comment.destroy
  end
end
