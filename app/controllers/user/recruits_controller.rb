class User::RecruitsController < ApplicationController
  before_action :ensure_correct_recruit, except: [:new, :index, :create, :schedule]
  before_action :set_app_requirements, only: [:new, :create, :edit]

  def new
    @recruit = Recruit.new
  end

  def index
    @recruits = Recruit.includes(:user)
  end

  def show
    @recruit_comment = RecruitComment.new
    @reserve = Reserve.new
    @entry_list = @recruit.entry_conditions
    @form_list = @recruit.play_forms
  end

  def edit
  end

  def update
    play_form_ids = params[:recruit][:play_form_ids]
    entry_condition_ids = params[:recruit][:entry_condition_ids]

    if @recruit.update(recruit_params)
      unless play_form_ids.present?
        RecruitPlayForm.bulk_create(@recruit.id, play_form_ids)
      end
      unless entry_condition_ids.present?
        RecruitEntryCondition.bulk_create(@recruit.id, entry_condition_ids)
      end
      redirect_to recruit_path
    else
      render :edit
    end

  end

  def create
    @recruit = Recruit.new(recruit_params)
    @recruit.user_id = current_user.id
    play_form_ids = params[:recruit][:play_form_ids]
    entry_condition_ids = params[:recruit][:entry_condition_ids]
    if @recruit.save
      RecruitPlayForm.bulk_create(@recruit.id, play_form_ids)
      RecruitEntryCondition.bulk_create(@recruit.id, entry_condition_ids)
      redirect_to recruit_path(@recruit)
    else
      render :new
    end
  end

  def destroy
    @recruit.destroy
    redirect_to home_path
  end

  def schedule
    date = params[:date]
    @recruits = Recruit.where(hold_datetime: date.in_time_zone.all_day)
  end

  def reserve_list
    @reserves = @recruit.reserves
  end

  private

  def ensure_correct_recruit
    @recruit = Recruit.find(params[:id])
  end

  def set_app_requirements
    @entry_conditions = EntryCondition.all
    @play_forms = PlayForm.all
  end

  def recruit_params
    params.require(:recruit).permit(
      :title,
      :start_time,
      :time_required,
      :capacity,
      :explanation,
      :discord_server_link,
      { play_form_ids: [] },
      { entry_condition_ids: [] }
    )
  end
end
