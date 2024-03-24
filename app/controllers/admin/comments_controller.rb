class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  def destroy
    comment = BookComment.find(params[:id])
    comment.destroy
  end
end
