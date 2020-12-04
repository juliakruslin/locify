class ChatroomsController < ApplicationController
  def show
    @message = Message.new
    @chatroom = Chatroom.find(params[:id])
  end

  def create
    @store = User.find(params[:id])
    @chatroom = Chatroom.find_or_create_by(store: @store, user: current_user)
    redirect_to chatroom_path(@chatroom)
  end

  def index
    @chatrooms = Chatroom.where(user_id: current_user.id)
    @store_chatrooms = Chatroom.where(store_id: current_user.id)
  end
end
