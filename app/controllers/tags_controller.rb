class TagsController < ApplicationController
  before_action :authenticate_user!, except: [:destroy]
  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to request.referer
  end
  def index
    @books = Book.all
    @tag_list = Tag.all
  end
end
