class User::RecruitCommentsController < ApplicationController
  before_action :set_recruit
  include User::NotificationsHelper

  def create
    @recruit_comment = current_user.recruit_comments.new(comment_params)
    @recruit_comment.recruit_id = @recruit.id
    @recruit_comment.save
    # コメント投稿後に募集投稿主に通知する
    create_notification(current_user,
                        @recruit.user,
                        @recruit.id,
                        @recruit_comment.id,
                        nil,
                        nil,
                        "comment")
  end

  def destroy
    @recruit_comment = @recruit.recruit_comments.find(params[:id])
    @recruit_comment.destroy
  end

  private

  def set_recruit
    @recruit = Recruit.find(params[:recruit_id])
    @recruit_comments = @recruit.recruit_comments.valid
  end

  def comment_params
    params.require(:recruit_comment).permit(:comment)
  end
end
