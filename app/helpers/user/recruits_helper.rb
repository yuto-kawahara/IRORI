module User::RecruitsHelper
  # 予約確定人数を算出
  def remain_count(recruit)
    capacity = recruit.capacity
    if recruit.recruit_status_before_type_cast < Recruit.recruit_statuses[:end_recruit]
      reserve_count = recruit.reserves.where(reserve_status: "approve_reserve").count
    else
      reserve_count = recruit.reserves.where(reserve_status: "confirm_reserve").count
    end
    remain = "あと#{capacity - reserve_count}人"
    return remain
  end

  # 開始日時の表示成型
  def calc_start_time(start_time, time_required)
    year = tag.span(start_time.year, class: "year")
    month = tag.span(start_time.month, class: "month")
    day = tag.span(start_time.day, class: "day")
    if t('date.abbr_day_names')[start_time.wday] == "土"
      wday = tag.span(t('date.abbr_day_names')[start_time.wday], class: "wday wday__stu")
    elsif t('date.abbr_day_names')[start_time.wday] == "日"
      wday = tag.span(t('date.abbr_day_names')[start_time.wday], class: "wday wday__sun")
    else
      wday = tag.span(t('date.abbr_day_names')[start_time.wday], class: "wday")
    end
    finish_hour = start_time.hour + time_required
    min = start_time.strftime("%M")
    date = tag.div(year + "年" + month + "月" + day + "日" + "("+ wday + ")", class: "day_upper")
    finish = "#{finish_hour}:#{min}"
    time = tag.span(start_time.strftime("%H:%M～") + finish)

    return date + time
  end

  # 募集ステータスによってactive/no_activeを設定
  def recruit_status(status)
    case status
      when "now_recruit", "few_recruit" then
        @status = "active"
        return @status

      when "end_recruit","expired_recruit","reminded_recruit" then
        @status = "no_active"
        return @status
    end
  end
end
