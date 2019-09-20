module NotificationsHelper
  def unread_notification_count
    current_user.passive_notifications.where(checked: false).count
  end
end
