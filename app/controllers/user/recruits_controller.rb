class User::RecruitsController < ApplicationController
  before_action :ensure_correct_recruit, except: [:new, :create, :schedule, :today, :week, :month]
  before_action :set_app_requirements, only: [:new, :create, :edit]

  def new
    @recruit = Recruit.new
  end

  def show
    @recruit_comment = RecruitComment.new
    @recruit_comments = @recruit.recruit_comments.valid.includes(:user)
    @reserve = Reserve.new
    @reserve_count = @recruit.reserves.where(reserve_status: "approve_reserve").count
    @entry_list = @recruit.entry_conditions
    @form_list = @recruit.play_forms
  end

  def edit
  end

  def update
    play_form_ids = params[:recruit][:play_form_ids]
    entry_condition_ids = params[:recruit][:entry_condition_ids]
    start_time = params[:recruit][:start_time]

    if @recruit.update(recruit_params)
      if play_form_ids.blank?
        RecruitPlayForm.bulk_create(@recruit.id, play_form_ids)
      end
      if entry_condition_ids.blank?
        RecruitEntryCondition.bulk_create(@recruit.id, entry_condition_ids)
      end
      # 更新した開始日程が現在時刻以上の場合、"募集中"に更新する
      if start_time >= Time.current
        @recruit.update_attributes(recruit_status: "now_recruit")
      end
      redirect_to recruit_path
    else
      create_input_valid(@recruit.errors)
      redirect_to edit_recruit_path
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
    @recruits = @recruits.includes(:user, :play_forms)
    @recruits = @recruits.valid.order(start_time: :desc).page(params[:page])
  end

  def today
    @recruits = Recruit.includes(:user, :play_forms)
    @recruits = @recruits.where(start_time: Time.current.in_time_zone.all_day)
    @recruits = @recruits.where.not(recruit_status: "expired_recruit")
    @recruits = @recruits.valid.order(start_time: :desc).page(params[:page])
  end

  def week
    @recruits = Recruit.valid
    @recruits = @recruits.where.not(recruit_status: "expired_recruit")
  end

  def month
    @recruits = Recruit.valid
    @recruits = @recruits.where.not(recruit_status: "expired_recruit")
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
