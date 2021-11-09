class User::EvaluationsController < ApplicationController
  def index
    @users = User.valid
    @evaluation = Evaluation.new
    @evaluations = Evaluation.where(reviewer_id: current_user.id).page(params[:page])
  end

  def create
    @evaluation = current_user.reviewer.new(evaluation_params)
    if @evaluation.save
      redirect_to user_evaluations_path
    else
      @users = User.valid
      @evaluation = Evaluation.new
      @evaluations = Evaluation.where(reviewer_id: current_user.id).page(params[:page])
      render :index
    end
  end

  def destory
  end

  private

  def evaluation_params
    params.require(:evaluation).permit(:reviewee_id, :stars, :comment)
  end
end
