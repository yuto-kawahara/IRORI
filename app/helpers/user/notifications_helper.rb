module User::NotificationsHelper
  def create_notification(send_user, receive_user, recruit_id, recruit_comment_id, message_id, action)
    unless send_user.id == receive_user.id
      notification = send_user.active_notifications.new(
        recruit_id: recruit_id,
        recruit_comment_id: recruit_comment_id,
        message_id: message_id,
        visited_id: receive_user.id,
        action: action
      )
      if notification.valid?
        notification.save
      end
    end
  end

  def notification_form(notification)
    @visitor = notification.visitor
    @recruit = notification.recruit
    @comment = nil
    @visitor_comment = notification.recruit_comment_id
    @visitor_message = notification.message_id
    case notification.action
      when "follow" then
        user = tag.a(notification.visitor.nickname, href:profile_user_path(@visitor), style:"font-weight: bold;")
        user + "さんにフォローされました"
      when "comment" then
        @comment = RecruitComment.find_by(id: @visitor_comment)&.comment
        user = tag.a(notification.visitor.nickname, href:profile_user_path(@visitor), style:"font-weight: bold;")
        content = tag.a(@recruit.title, href:recruit_path(@recruit), style:"font-weight: bold;")
        user + "さんが" + content + "にコメントしました"
      when "reserve" then
        user = tag.a(notification.visitor.nickname, href:profile_user_path(@visitor), style:"font-weight: bold;")
        content = tag.a(@recruit.title, href:recruit_path(@recruit), style:"font-weight: bold;")
        user + "さんが" + content + "に予約しました"
      when "cancel" then
        user = tag.a(notification.visitor.nickname, href:profile_user_path(@visitor), style:"font-weight: bold;")
        content = tag.a(@recruit.title, href:recruit_path(@recruit), style:"font-weight: bold;")
        user + "さんが" + content + "を予約キャンセルしました"
      when "message" then
        @comment = Message.find_by(id: @visitor_message)&.content
        if @comment.include?("a href=https://discord")
          @comment = @comment.html_safe
        end
        user = tag.a(notification.visitor.nickname, href:profile_user_path(@visitor), style:"font-weight: bold;")
        content = tag.a("DM", href:message_path(notification.message.room), style:"font-weight: bold;")
        user + "さんとの" + content + "にメッセージがありました"
    end

  end
end
