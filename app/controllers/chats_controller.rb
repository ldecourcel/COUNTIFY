class ChatsController < ApplicationController
  def show
    @chat = Chat.find(params[:id])
    @company = @chat.company
    authorize @chat
    @message = Message.new
  end
end
