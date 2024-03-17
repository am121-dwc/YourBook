class EventsController < ApplicationController
  def create
    # 受け取ったイベント情報をUserに紐付けて保存する処理を実装します
    @event = Event.new(event_params)
   if @event.save
    redirect_to request.referer
   else
    redirect_to books_path
   end
  end
  private
  def event_params
    params.require(:event).permit(:title, :start_time, :end_time)
  end
end
