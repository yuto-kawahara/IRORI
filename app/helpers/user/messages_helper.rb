module User::MessagesHelper
  require "uri"

  def room_create_search(send_user, receive_user, message, send_method)
    rooms = send_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: receive_user.id, room_id: rooms)

    if user_rooms.present?
      room = user_rooms.room
    else
      room = Room.new
      room.save
      UserRoom.create(user_id: send_user.id, room_id: room.id)
      UserRoom.create(user_id: receive_user.id, room_id: room.id)
    end
    @messages = room.messages.includes(:user, :room)
    @message = send_user.messages.new(room_id: room.id, content: message)
    if send_method == "broadcast"
      @message.save
      create_notification(send_user,
                          receive_user,
                          nil,
                          nil,
                          @message.id,
                          nil,
                          "message")
    end
  end

  def text_url_to_link(text)
    URI.extract(text, ["http", "https"]).uniq.each do |url|
      sub_text = ""
      sub_text << "<a href=" << url << " target=\"_blank\">" << url << "</a>"
      text.gsub!(url, "#{sub_text}")
    end
    text
  end
end
