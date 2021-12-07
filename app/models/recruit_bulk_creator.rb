class RecruitBulkCreator
  def initialize(recruit, play_form_ids, entry_condition_ids, start_time)
    @recruit = recruit
    @play_form_ids = play_form_ids
    @entry_condition_ids = entry_condition_ids
    @start_time = start_time
  end

  def update
    if @play_form_ids.blank?
      recruit_play_form_bulk_create
    end
    if @entry_condition_ids.blank?
      recruit_entry_condition_bulk_create
    end
    # 更新した開始日程が現在時刻以上の場合、"募集中"に更新する
    if @start_time >= Time.current
      @recruit.update_attributes(recruit_status: "now_recruit")
    end
  end

  def create
    recruit_play_form_bulk_create
    recruit_entry_condition_bulk_create
  end

  private

  def recruit_play_form_bulk_create
    RecruitPlayForm.bulk_create(@recruit.id, @play_form_ids)
  end

  def recruit_entry_condition_bulk_create
    RecruitEntryCondition.bulk_create(@recruit.id, @entry_condition_ids)
  end

  def start_time_future?
    @start_time >= Time.current
  end
end