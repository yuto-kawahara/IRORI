module User::NotificationsHelper
  def create_notification(send_user, receive_user, recruit_id, recruit_comment_id, message_id, evaluation_id, action)
    unless send_user.id == receive_user.id
      notification = send_user.active_notifications.new(
        visited_id: receive_user.id,
        recruit_id: recruit_id,
        recruit_comment_id: recruit_comment_id,
        message_id: message_id,
        evaluation_id: evaluation_id,
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
    @visitor_review  = notification.evaluation_id
    case notification.action
      when "follow" then
        user = tag.a(@visitor.nickname, href: profile_user_path(@visitor), class: "notice_nickname")
        user + "さんにフォローされました"
      when "comment" then
        @comment = RecruitComment.find_by(id: @visitor_comment)&.comment
        user = tag.a(@visitor.nickname, href: profile_user_path(@visitor), class: "notice_nickname")
        content = tag.a(@recruit.title, href: recruit_path(@recruit), class: "notice_action")
        user + "さんが" + content + "にコメントしました"
      when "reserve" then
        user = tag.a(@visitor.nickname, href: profile_user_path(@visitor), class: "notice_nickname")
        content = tag.a(@recruit.title, href: recruit_path(@recruit), class: "notice_action")
        user + "さんが" + content + "に予約しました"
      when "cancel" then
        user = tag.a(@visitor.nickname, href: profile_user_path(@visitor), class: "notice_nickname")
        content = tag.a(@recruit.title, href: recruit_path(@recruit), class: "notice_action")
        user + "さんが" + content + "を予約キャンセルしました"
      when "message" then
        @comment = Message.find_by(id: @visitor_message)&.content
        if @comment.present?
          if @comment.include?("a href=https://discord")
            @comment = @comment.html_safe
          end
        end
        user = tag.a(@visitor.nickname, href: profile_user_path(@visitor), class: "notice_nickname")
        content = tag.a("DM", href: message_path(@visitor.id), class: "notice_action")
        user + "さんとの" + content + "にメッセージがありました"
      when "review" then
        user = tag.a(@visitor.nickname, href: profile_user_path(@visitor), class: "notice_nickname")
        content = link_to "卓報告", evaluation_path(@visitor_review), class: "notice_action", remote: true
        user + "さんに" + content + "で評価されました"
    end
  end
end
