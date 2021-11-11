class User::EvaluationsController < ApplicationController
  include User::NotificationsHelper

  def new
    @evaluation = Evaluation.new
  end

  def show
    @evaluation = Evaluation.find(params[:id])
  end

  def index
    @users = User.valid
    @evaluation = Evaluation.new
    @evaluations = Evaluation.includes(:reviewer, :reviewee).where(reviewer_id: current_user.id)
    @evaluations = @evaluations.sorted.page(params[:page])
  end

  def other_index
    @users = User.valid
    @evaluation = Evaluation.new
    @evaluations = Evaluation.includes(:reviewer, :reviewee)
    @evaluations = @evaluations.not_current(current_user)
    @evaluations = @evaluations.valid.sorted.page(params[:page])
  end

  def create
    @evaluation = current_user.reviewer.new(evaluation_params)
    reviewee = User.find_by(nickname: params[:evaluation][:nickname])
    @evaluation.reviewee_id = reviewee.id

    if @evaluation.save
      create_notification(current_user,
                          reviewee,
                          nil,
                          nil,
                          nil,
                          @evaluation.id,
                          "review")
      redirect_to user_evaluations_path
    else
      @users = User.valid
      @evaluation = Evaluation.new
      @evaluations = Evaluation.where(reviewer_id: current_user.id).sorted.page(params[:page])
      render :index
    end
  end

  def destroy
    @evaluation = Evaluation.find(params[:id])
    @evaluation.destroy
  end

  private

  def evaluation_params
    params.require(:evaluation).permit(:stars, :comment)
  end
end
