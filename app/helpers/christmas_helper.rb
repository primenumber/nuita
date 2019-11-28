module ChristmasHelper
  # 再利用不可能
  def christmas_stamps_for(user, calendar_range)
    stamps = user.stamps.where(:targeted_at => calendar_range)

    calendarize_data(stamps, column: :targeted_at)
  end

  def class_for_christmas_date(date)
    datetime = date.to_time
    if datetime > Time.zone.now
      "not-yet"
    elsif datetime > Time.zone.now - 1.day
      "today"
    else

    end
  end
end
