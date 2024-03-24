class EventsController < ApplicationController
  before_action :authenticate_user!
  def create
    # 受け取ったイベント情報をUserに紐付けて保存する処理を実装します
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    @event.save   #!
    redirect_to request.referer
  end
  def index
    @events = current_user.events
  end
  private
  def event_params
    params.require(:event).permit(:title, :start, :end)
  end
end
