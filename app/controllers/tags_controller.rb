class TagsController < ApplicationController
  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to request.referer
  end
end
