module User::RecruitsHelper
  def remain_count(recruit)
    capa = recruit.capacity
    reserve_count = recruit.reserves.where(reserve_status: "approve_reserve").count
    remain = tag.span("あと#{capa - reserve_count}人", class: "remain_tag")
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
    hour = start_time.hour + time_required
    min = start_time.min
    date = year + "年" + month + "月" + day + "日" + "("+ wday + ")"
    start = date + start_time.strftime("%H:%M～")
    finish = "#{hour}:#{min}"
    return start + finish
  end
end
