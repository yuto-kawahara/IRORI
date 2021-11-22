module User::RecruitsHelper
  def remain_count(recruit)
    capa = recruit.capacity
    reserve_count = recruit.reserves.where(reserve_status: "approve_reserve").count
    remain = "あと#{capa - reserve_count}人"
    return remain
  end

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
