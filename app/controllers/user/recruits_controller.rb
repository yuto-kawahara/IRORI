class User::RecruitsController < ApplicationController
  before_action :ensure_correct_recruit, except: [:new, :index, :create, :schedule]
  before_action :set_app_requirements, only: [:new, :create, :edit]

  def new
    @recruit = Recruit.new
  end

  def index
    @recruits = Recruit.valid.includes(:user)
  end

  def show
    @recruit_comment = RecruitComment.new
    @recruit_comments = @recruit.recruit_comments.valid
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
      if play_form_ids.blank?
        RecruitPlayForm.bulk_create(@recruit.id, play_form_ids)
      end
      if entry_condition_ids.blank?
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
      create_input_valid(@recruit.errors)
      redirect_to new_recruit_path
    end
  end

  def create_input_valid(errors)
    if errors.details.include?(:title)
      flash[:title] = "タイトルを入力してください"
    end
    if errors.details.include?(:start_time)
      flash[:start_time] = "募集日時を選択してください"
    end
    if errors.details.include?(:time_required)
      flash[:time_required] = "所要時間を選択してください"
    end
    if errors.details.include?(:capacity)
      flash[:capacity] = "募集人員を選択してください"
    end
    if errors.details.include?(:discord_server_link)
      flash[:discord_server_link] = "Discordのサーバーリンクを入力してください"
    end
  end

  def destroy
    @recruit.destroy
    redirect_to home_path
  end

  def schedule
    date = params[:date]
    @recruits = Recruit.where(start_time: date.in_time_zone.all_day)
    @recruits = @recruits.includes(:user, :entry_conditions, :play_forms)
    @recruits = @recruits.valid.order(start_time: :desc).page(params[:page])
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
      :image,
      :discord_server_link,
      { play_form_ids: [] },
      { entry_condition_ids: [] }
    )
  end
end
