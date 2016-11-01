class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :destroy]
  before_action :set_message, only: [:show, :destroy]
  before_action :set_messages_count

  # GET /messages
  # GET /messages.json
  def index
    @messages = current_user.profileable.messages
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message.readed = true
    respond_to do |format|
      if @message.save
        format.js
      else
        format.js
      end
    end
  end

  def read_all
    Message.update(readed: true)

    respond_to do |format|
      format.js
    end
  end

  def unread_all
    Message.update(readed: false)

    respond_to do |format|
      format.js
    end
  end  

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    respond_to do |format|
      if @message.destroy
        @messages_count -= 1
        format.js
      else
        format.js
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    def set_messages_count
      @messages_count = Message.count
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:title, :body, :footer, :ownerable_id, :ownerable_type, :asociateable_id, :asociateable_type)
    end
end
