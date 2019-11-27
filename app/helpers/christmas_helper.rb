module ChristmasHelper
  # 再利用不可能
  def christmas_stamps_for(user, calendar_range)
    stamps = user.stamps.where(:targeted_at => calendar_range)

    calendarize_data(stamps, column: :targeted_at)
  end
end
