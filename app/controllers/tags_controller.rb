class TagsController < ApplicationController
  before_action :authenticate_user!
  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to request.referer
  end
end
