class ChatroomsController < ApplicationController
  before_action :find_chat_rooms, only: [:show, :index]
  def show
    @message = Message.new
    @chatroom = Chatroom.find(params[:id])
    redirect_to(root_path) unless current_user == @chatroom.user || current_user == @chatroom.store
  end

  def create
    @store = User.find(params[:id])
    @chatroom = Chatroom.find_or_create_by(store: @store, user: current_user)
    redirect_to chatroom_path(@chatroom)
  end

  def index
  end

  private

  def find_chat_rooms
    @chatrooms = Chatroom.where(user_id: current_user.id)
    @store_chatrooms = Chatroom.where(store_id: current_user.id)
  end
end
